package main

import (
	"testing"

	"github.com/david/agent-tracker/internal/ipc"
)

func TestBuildVisibleTaskRowsKeepsChildrenIndentedUnderParent(t *testing.T) {
	tasks := []ipc.Task{
		{TaskID: "root", Summary: "primary", Status: statusInProgress, ChildCount: 1},
		{TaskID: "child", ParentTaskID: "root", Summary: "subagent", Status: statusInProgress, IsSubagent: true},
	}

	rows := buildVisibleTaskRows(tasks, map[string]bool{})
	if len(rows) != 2 {
		t.Fatalf("expected 2 rows, got %d", len(rows))
	}
	if rows[0].Depth != 0 {
		t.Fatalf("expected root depth 0, got %d", rows[0].Depth)
	}
	if rows[1].Depth != 1 {
		t.Fatalf("expected child depth 1, got %d", rows[1].Depth)
	}
	if rows[0].VisibleChildCount != 1 {
		t.Fatalf("expected 1 visible child, got %d", rows[0].VisibleChildCount)
	}
}

func TestBuildVisibleTaskRowsRespectsCollapsedParents(t *testing.T) {
	tasks := []ipc.Task{
		{TaskID: "root", Summary: "primary", Status: statusInProgress, ChildCount: 1},
		{TaskID: "child", ParentTaskID: "root", Summary: "subagent", Status: statusInProgress, IsSubagent: true},
	}

	rows := buildVisibleTaskRows(tasks, map[string]bool{"root": true})
	if len(rows) != 1 {
		t.Fatalf("expected 1 row when collapsed, got %d", len(rows))
	}
	if rows[0].Task.TaskID != "root" {
		t.Fatalf("expected only root row, got %+v", rows[0].Task)
	}
}

func TestBuildVisibleTaskRowsPromotesOrphanChildToRoot(t *testing.T) {
	tasks := []ipc.Task{{TaskID: "child", ParentTaskID: "missing-root", Summary: "subagent", Status: statusInProgress, IsSubagent: true}}

	rows := buildVisibleTaskRows(tasks, map[string]bool{})
	if len(rows) != 1 {
		t.Fatalf("expected orphan child to remain visible, got %d rows", len(rows))
	}
	if rows[0].Depth != 0 {
		t.Fatalf("expected orphan child to be rendered as root depth 0, got %d", rows[0].Depth)
	}
	if rows[0].Task.TaskID != "child" {
		t.Fatalf("expected child task to remain visible, got %+v", rows[0].Task)
	}
}

func TestBuildVisibleTaskRowsUsesVisibleChildrenForExpandState(t *testing.T) {
	tasks := []ipc.Task{{TaskID: "root", Summary: "primary", Status: statusInProgress, ChildCount: 2}}

	rows := buildVisibleTaskRows(tasks, map[string]bool{})
	if len(rows) != 1 {
		t.Fatalf("expected one root row, got %d", len(rows))
	}
	if rows[0].VisibleChildCount != 0 {
		t.Fatalf("expected no visible children, got %d", rows[0].VisibleChildCount)
	}
}
