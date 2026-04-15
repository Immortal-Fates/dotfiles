package main

import (
	"strings"

	"github.com/david/agent-tracker/internal/ipc"
)

type taskRow struct {
	Task              ipc.Task
	Depth             int
	VisibleChildCount int
}

func buildVisibleTaskRows(tasks []ipc.Task, collapsed map[string]bool) []taskRow {
	ordered := append([]ipc.Task(nil), tasks...)
	sortTasks(ordered)

	byParent := make(map[string][]ipc.Task)
	taskIDs := make(map[string]struct{}, len(ordered))
	roots := make([]ipc.Task, 0, len(ordered))
	for _, task := range ordered {
		if taskID := strings.TrimSpace(task.TaskID); taskID != "" {
			taskIDs[taskID] = struct{}{}
		}
	}
	for _, task := range ordered {
		parentID := strings.TrimSpace(task.ParentTaskID)
		if parentID == "" {
			roots = append(roots, task)
			continue
		}
		if _, ok := taskIDs[parentID]; !ok {
			roots = append(roots, task)
			continue
		}
		byParent[parentID] = append(byParent[parentID], task)
	}

	rows := make([]taskRow, 0, len(ordered))
	var visit func(task ipc.Task, depth int)
	visit = func(task ipc.Task, depth int) {
		visibleChildren := byParent[strings.TrimSpace(task.TaskID)]
		rows = append(rows, taskRow{Task: task, Depth: depth, VisibleChildCount: len(visibleChildren)})
		if collapsed[strings.TrimSpace(task.TaskID)] {
			return
		}
		for _, child := range visibleChildren {
			visit(child, depth+1)
		}
	}

	for _, root := range roots {
		visit(root, 0)
	}

	return rows
}
