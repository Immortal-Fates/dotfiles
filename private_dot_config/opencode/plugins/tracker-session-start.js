const TRACKER_START_SCRIPT = "/home/immortal-pc1/.config/agent-tracker/scripts/auto_start_session.py";

async function startTrackerSession(session) {
  const proc = Bun.spawn([
    "/usr/bin/python3",
    TRACKER_START_SCRIPT,
    "--source",
    "opencode",
    "--session-id",
    session.id,
    "--cwd",
    session.directory || "",
    "--task-id",
    session.id,
    ...(session.parentID ? ["--parent-task-id", session.parentID] : []),
  ], {
    stdin: "ignore",
    stdout: "ignore",
    stderr: "ignore",
  });
  await proc.exited;
}

export const TrackerSessionStartPlugin = async () => {
  const seenSessions = new Set();

  return {
    event: async ({ event }) => {
      if (event.type !== "session.created") {
        return;
      }
      const session = event.properties?.info;
      if (!session?.id || seenSessions.has(session.id)) {
        return;
      }
      seenSessions.add(session.id);
      await startTrackerSession(session);
    },
  };
};
