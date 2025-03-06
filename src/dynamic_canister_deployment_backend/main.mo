import Greeter "greeter";
import IC "types";
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";
import Vector "mo:vector";
actor Manager {
  private stable let greeters = Vector.new<Greeter.Greeter>();
  let ic : IC.Self = actor "aaaaa-aa";

  public shared ({caller}) func createGreeter() : async () {
    try {
      let greeter = await Greeter.Greeter(caller);
      Vector.add(greeters, greeter);
      let canisterid = Principal.fromActor(greeter);
      let controllers : ?[Principal] = ?[caller, Principal.fromActor(Manager)];
      await ic.update_settings({
        canister_id = canisterid;
        settings = {
          controllers = controllers;
          freezing_threshold = null;
          memory_allocation = null;
          compute_allocation = null
        }
      })
    } catch (err) {
      throw (err)
    } finally {
      Debug.print("Greeter instantiation processed!")
    }
  }
}
