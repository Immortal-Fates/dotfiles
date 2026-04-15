package main

import (
	"strings"
	"testing"
)

func TestStartTaskStoresExplicitParentChildRelationship(t *testing.T) {
	s := newServer()

	root := tmuxTarget{SessionID: "$1", WindowID: "@1", PaneID: "%1"}
	child := tmuxTarget{SessionID: "$1", WindowID: "@1", PaneID: "%1"}

	if err := s.startTask(root, startTaskOptions{
		Summary: "root task",
		Source:  "opencode",
		TaskID:  "root-session",
	}); err != nil {
		t.Fatal(err)
	}
	if err := s.startTask(child, startTaskOptions{
		Summary:      "child task",
		Source:       "opencode",
		TaskID:       "child-session",
		ParentTaskID: "root-session",
	}); err != nil {
		t.Fatal(err)
	}

	env := s.buildStateEnvelope()
	if got := stateSummary(env.Tasks, nil, nil); !strings.Contains(got, "Active Tasks 1") {
		t.Fatalf("expected only root task to count, got %q", got)
	}

	var rootTask, childTaskFound bool
	for _, task := range env.Tasks {
		switch task.TaskID {
		case "root-session":
			rootTask = true
			if task.ChildCount != 1 {
				t.Fatalf("expected root child count 1, got %d", task.ChildCount)
			}
		case "child-session":
			childTaskFound = true
			if task.ParentTaskID != "root-session" {
				t.Fatalf("expected child parent root-session, got %q", task.ParentTaskID)
			}
		}
	}

	if !rootTask || !childTaskFound {
		t.Fatalf("expected both root and child tasks in state: %+v", env.Tasks)
	}
}

func TestTaskLifecycleUsesTaskIDWhenPaneMatchesMultipleTasks(t *testing.T) {
	s := newServer()
	target := tmuxTarget{SessionID: "$1", WindowID: "@1", PaneID: "%1"}

	if err := s.startTask(target, startTaskOptions{Summary: "root task", Source: "opencode", TaskID: "root-session"}); err != nil {
		t.Fatal(err)
	}
	if err := s.startTask(target, startTaskOptions{Summary: "child task", Source: "opencode", TaskID: "child-session", ParentTaskID: "root-session"}); err != nil {
		t.Fatal(err)
	}

	if err := s.finishTask("child-session", target, "done", "opencode"); err != nil {
		t.Fatal(err)
	}
	child := s.tasks["child-session"]
	if child == nil || child.Status != statusCompleted {
		t.Fatalf("expected child task to be completed, got %+v", child)
	}
	if s.tasks["root-session"].Status != statusInProgress {
		t.Fatalf("expected root task to remain in progress, got %+v", s.tasks["root-session"])
	}

	if err := s.acknowledgeTask("child-session", "opencode", target.SessionID, target.WindowID, target.PaneID); err != nil {
		t.Fatal(err)
	}
	if !s.tasks["child-session"].Acknowledged {
		t.Fatalf("expected child task to be acknowledged, got %+v", s.tasks["child-session"])
	}

	if err := s.deleteTask("child-session", "opencode", target.SessionID, target.WindowID, target.PaneID); err != nil {
		t.Fatal(err)
	}
	if _, ok := s.tasks["child-session"]; ok {
		t.Fatalf("expected child task to be deleted")
	}
	if _, ok := s.tasks["root-session"]; !ok {
		t.Fatalf("expected root task to remain after deleting child")
	}
}
