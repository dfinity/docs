actor Daemon {
  stable var running = false;

  public func launch() : async Text {
    running := true;
    debug_show "The daemon process is running";
  };

  public func stop(): async Text {
    running := false;
    debug_show "The daemon is stopped";
  };
};
