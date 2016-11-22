(* {{{ COPYING *(

  This file is part of a binding for OCaml to the Chipmunk library.

  Copyright (C) 2008  Florent Monnier  <monnier.florent(_)gmail.com>

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the "Software"),
  to deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  The Software is provided "as is", without warranty of any kind, express or
  implied, including but not limited to the warranties of merchantability,
  fitness for a particular purpose and noninfringement. In no event shall
  the authors or copyright holders be liable for any claim, damages or other
  liability, whether in an action of contract, tort or otherwise, arising
  from, out of or in connection with the software or the use or other dealings
  in the Software.

)* }}} *)

(** {2 Chipmunk Physics Engine} *)

(** Chipmunk Game Dynamics. Provides fast, easy to use, robust physics. *)

(** {{:http://chipmunk-physics.net/documentation.php}
    Officical documentation of Chipmunk} *)

(* {{{ Low Level module *)
module Low_level : sig
(** {2 Low Level Chipmunk Bindings} *)

external cpInitChipmunk: unit -> unit = "ml_cpInitChipmunk"

external get_compile_version: unit -> int * int * int = "get_chipmunk_compile_version"


type cpVect = {cp_x:float; cp_y:float}

external cpMomentForCircle: m:float -> r1:float -> r2:float -> offset:cpVect -> float = "ml_cpMomentForCircle"
external cpMomentForPoly: m:float -> verts:cpVect array -> offset:cpVect -> float = "ml_cpMomentForPoly"

external cpAreaForPoly: verts:cpVect array -> float = "ml_cpAreaForPoly"


(** {4 Chipmunk Vectors} *)

# 54 "chipmunk.ml.pp"

val vec2d: float * float -> cpVect
val cpv: x:float -> y:float -> cpVect
val cpvzero: unit -> cpVect
val cpvadd : v1:cpVect -> v2:cpVect -> cpVect
val cpvrotate : v1:cpVect -> v2:cpVect -> cpVect
val cpvneg : v:cpVect -> cpVect
val cpvsub : v1:cpVect -> v2:cpVect -> cpVect
val cpvmult : v:cpVect -> s:float -> cpVect
val cpvdot : v1:cpVect -> v2:cpVect -> float
val cpvcross : v1:cpVect -> v2:cpVect -> float
val cpvperp : v:cpVect -> cpVect
val cpvrperp : v:cpVect -> cpVect
val cpvproject : v1:cpVect -> v2:cpVect -> cpVect
val cpvrotate : v1:cpVect -> v2:cpVect -> cpVect
val cpvunrotate : v1:cpVect -> v2:cpVect -> cpVect
val cpvlength : v:cpVect -> float
val cpvlengthsq : v:cpVect -> float
val cpvnormalize : v:cpVect -> cpVect
val cpvforangle : a:float -> cpVect
val cpvtoangle : v:cpVect -> float
val cpvlerp : v1:cpVect -> v2:cpVect -> t:float -> cpVect

# 131 "chipmunk.ml.pp"


(** {3 Chipmunk Bodies} *)

type cpBody
external cpBodyNew: m:float -> i:float -> cpBody = "ml_cpBodyNew"

external cpBodyGetUserData: cpBody -> int = "ml_cpBodyGetUserData"

external cpBodySetUserData: cpBody -> int -> unit = "ml_cpBodySetUserData"


(** {3 Chipmunk Spaces} *)

type cpSpace
external cpSpaceNew: unit -> cpSpace = "ml_cpSpaceNew"


(** {3 Chipmunk Shapes} *)

type cpShape
external cpSegmentShapeNew: body:cpBody -> a:cpVect -> b:cpVect -> r:float -> cpShape = "ml_cpSegmentShapeNew"
(** [r] is the thickness *)

external cpPolyShapeNew: body:cpBody -> verts:cpVect array -> offset:cpVect -> cpShape = "ml_cpPolyShapeNew"
external cpCircleShapeNew: body:cpBody -> radius:float -> offset:cpVect -> cpShape = "ml_cpCircleShapeNew"
external cpBoxShapeNew: body:cpBody -> width:float -> height:float -> cpShape = "ml_cpBoxShapeNew"

external cpShapeGetBody: shape:cpShape -> cpBody = "ml_cpShapeGetBody"


type cpCircleShape
type cpSegmentShape
type cpPolyShape
external cpCircleShape_of_cpShape: shape:cpShape -> cpCircleShape = "%identity"
external cpSegmentShape_of_cpShape: shape:cpShape -> cpSegmentShape = "%identity"
external cpPolyShape_of_cpShape: shape:cpShape -> cpPolyShape = "%identity"
(** unsafe convertion functions, use the high level module for a safe interface,
    or check type with [cpShapeGetType] before. *)

type cpShapeType =
  | CP_CIRCLE_SHAPE
  | CP_SEGMENT_SHAPE
  | CP_POLY_SHAPE
  | CP_NUM_SHAPES

external cpShapeGetType: shape:cpShape -> cpShapeType = "ml_cpShapeGetType"

type cpSegmentQueryInfo = {
  shape : cpShape;
  (** The shape that was hit, NULL if no collision occured. *)
  t : float;
  (** The normalized distance along the query segment in the range [0, 1]. *)
  n : cpVect;
  (** The normal of the surface hit. *)
}

external cpShapeSegmentQuery: shape:cpShape -> a:cpVect -> b:cpVect ->
  cpSegmentQueryInfo option = "ml_cpShapeSegmentQuery"

external cpSegmentQueryHitPoint: start:cpVect -> end_:cpVect -> info:cpSegmentQueryInfo -> cpVect
  = "ml_cpSegmentQueryHitPoint"

external cpSegmentQueryHitDist: start:cpVect -> end_:cpVect -> info:cpSegmentQueryInfo -> float
  = "ml_cpSegmentQueryHitDist"


(** Debug *)
external cpSpaceDump: space:cpSpace -> unit = "ml_cpSpaceDump"
external cpBodyDump: body:cpBody -> unit = "ml_cpBodyDump"

(** Chipmunk Bounding Box *)

type cpBB
external cpBBNew: l:float -> b:float -> r:float -> t:float -> cpBB = "ml_cpBBNew"
external cpBBFree: bb:cpBB -> unit = "ml_cpBBFree"

external cpBBIntersects: a:cpBB -> b:cpBB -> bool = "ml_cpBBIntersects"
external cpBBContainsBB: bb:cpBB -> other:cpBB -> bool = "ml_cpBBContainsBB"
external cpBBContainsVect: bb:cpBB -> v:cpVect -> bool = "ml_cpBBContainsVect"

external cpBBClampVect: bb:cpBB -> v:cpVect -> cpVect = "ml_cpBBClampVect"
external cpBBWrapVect: bb:cpBB -> v:cpVect -> cpVect = "ml_cpBBWrapVect"

external cpShapeGetBB: shape:cpShape -> cpBB = "ml_cpShapeGetBB"  (* TODO: test this function *)


(** {3 Chipmunk Joints} *)

type cpJointType =
  | CP_PIN_JOINT
  | CP_SLIDE_JOINT
  | CP_PIVOT_JOINT
  | CP_GROOVE_JOINT

type cpConstraint
type cpJoint

type cpPinJoint
type cpSlideJoint
type cpPivotJoint
type cpGrooveJoint

external cpPinJoint_of_cpJoint: joint:cpJoint -> cpPinJoint = "%identity"
external cpSlideJoint_of_cpJoint: joint:cpJoint -> cpSlideJoint = "%identity"
external cpPivotJoint_of_cpJoint: joint:cpJoint -> cpPivotJoint = "%identity"
external cpGrooveJoint_of_cpJoint: joint:cpJoint -> cpGrooveJoint = "%identity"
(** unsafe convertion functions, use the high level module for a safe interface.
    There is no low-level function to check the joint type. *)


(** {3 Chipmunk Contacts} *)

type cpContact



(** {4 Iterating} *)

type cpArbiter

external cpArbiterGetShapePA: arbiter:cpArbiter -> cpShape = "ml_cpArbiterGetShapePA"
external cpArbiterGetShapePB: arbiter:cpArbiter -> cpShape = "ml_cpArbiterGetShapePB"
external cpArbiterGetShapes: arbiter:cpArbiter -> cpShape * cpShape = "ml_cpArbiterGetShapes"


(** {5 Generated Part} *)

type cpVectArray = cpVect array

# 1 "chipmunk.gen.ml" 1
(* This is a generated file *)

external cpAreaForCircle : r1:float -> r2:float -> float = "ml_cpAreaForCircle"

external cpMomentForSegment : m:float -> a:cpVect -> b:cpVect -> float = "ml_cpMomentForSegment"

external cpAreaForSegment : a:cpVect -> b:cpVect -> r:float -> float = "ml_cpAreaForSegment"

external cpMomentForBox : m:float -> width:float -> height:float -> float = "ml_cpMomentForBox"

external cpSpaceDestroy : space:cpSpace -> unit = "ml_cpSpaceDestroy"

external cpSpaceFree : space:cpSpace -> unit = "ml_cpSpaceFree"

external cpSpaceAddShape : space:cpSpace -> shape:cpShape -> unit = "ml_cpSpaceAddShape"

external cpSpaceAddStaticShape : space:cpSpace -> shape:cpShape -> unit = "ml_cpSpaceAddStaticShape"

external cpSpaceAddBody : space:cpSpace -> body:cpBody -> unit = "ml_cpSpaceAddBody"

external cpSpaceAddConstraint : space:cpSpace -> constr:cpConstraint -> unit = "ml_cpSpaceAddConstraint"

external cpSpaceRemoveShape : space:cpSpace -> shape:cpShape -> unit = "ml_cpSpaceRemoveShape"

external cpSpaceRemoveStaticShape : space:cpSpace -> shape:cpShape -> unit = "ml_cpSpaceRemoveStaticShape"

external cpSpaceRemoveBody : space:cpSpace -> body:cpBody -> unit = "ml_cpSpaceRemoveBody"

external cpSpaceRemoveConstraint : space:cpSpace -> constr:cpConstraint -> unit = "ml_cpSpaceRemoveConstraint"

external cpSpaceStep : space:cpSpace -> dt:float -> unit = "ml_cpSpaceStep"

external cpSpaceIsLocked : space:cpSpace -> bool = "ml_cpSpaceIsLocked"

external cpSpaceContainsShape : space:cpSpace -> shape:cpShape -> bool = "ml_cpSpaceContainsShape"

external cpSpaceContainsBody : space:cpSpace -> body:cpBody -> bool = "ml_cpSpaceContainsBody"

external cpSpaceContainsConstraint : space:cpSpace -> constr:cpConstraint -> bool = "ml_cpSpaceContainsConstraint"

external cpSpaceReindexStatic : space:cpSpace -> unit = "ml_cpSpaceReindexStatic"

external cpSpaceReindexShape : space:cpSpace -> shape:cpShape -> unit = "ml_cpSpaceReindexShape"

external cpSpaceReindexShapesForBody : space:cpSpace -> body:cpBody -> unit = "ml_cpSpaceReindexShapesForBody"

external cpSpaceUseSpatialHash : space:cpSpace -> dim:float -> count:int -> unit = "ml_cpSpaceUseSpatialHash"

external cpSpaceRemoveCollisionHandler : space:cpSpace -> a:int -> b:int -> unit = "ml_cpSpaceRemoveCollisionHandler"

external my_cpSpaceSetDefaultCollisionHandler : space:cpSpace -> data:string -> unit = "ml_my_cpSpaceSetDefaultCollisionHandler"

external my_cpSpaceAddCollisionHandler : space:cpSpace -> a:int -> b:int -> data:string -> unit = "ml_my_cpSpaceAddCollisionHandler"

external cpSpaceGetIterations : space:cpSpace -> int = "ml_cpSpaceGetIterations"

external cpSpaceSetIterations : space:cpSpace -> iterations:int -> unit = "ml_cpSpaceSetIterations"

external cpSpaceGetGravity : space:cpSpace -> cpVect = "ml_cpSpaceGetGravity"

external cpSpaceSetGravity : space:cpSpace -> gravity:cpVect -> unit = "ml_cpSpaceSetGravity"

external cpSpaceGetDamping : space:cpSpace -> float = "ml_cpSpaceGetDamping"

external cpSpaceSetDamping : space:cpSpace -> damping:float -> unit = "ml_cpSpaceSetDamping"

external cpSpaceGetIdleSpeedThreshold : space:cpSpace -> float = "ml_cpSpaceGetIdleSpeedThreshold"

external cpSpaceSetIdleSpeedThreshold : space:cpSpace -> v:float -> unit = "ml_cpSpaceSetIdleSpeedThreshold"

external cpSpaceGetSleepTimeThreshold : space:cpSpace -> float = "ml_cpSpaceGetSleepTimeThreshold"

external cpSpaceSetSleepTimeThreshold : space:cpSpace -> v:float -> unit = "ml_cpSpaceSetSleepTimeThreshold"

external cpSpaceGetCollisionSlop : space:cpSpace -> float = "ml_cpSpaceGetCollisionSlop"

external cpSpaceSetCollisionSlop : space:cpSpace -> v:float -> unit = "ml_cpSpaceSetCollisionSlop"

external cpSpaceGetCollisionBias : space:cpSpace -> float = "ml_cpSpaceGetCollisionBias"

external cpSpaceSetCollisionBias : space:cpSpace -> v:float -> unit = "ml_cpSpaceSetCollisionBias"

external cpSpaceGetEnableContactGraph : space:cpSpace -> bool = "ml_cpSpaceGetEnableContactGraph"

external cpSpaceSetEnableContactGraph : space:cpSpace -> v:bool -> unit = "ml_cpSpaceSetEnableContactGraph"

external cpSpaceGetCurrentTimeStep : space:cpSpace -> float = "ml_cpSpaceGetCurrentTimeStep"

external cpBodyFree : body:cpBody -> unit = "ml_cpBodyFree"

external cpBodyUpdateVelocity : body:cpBody -> gravity:cpVect -> damping:float -> dt:float -> unit = "ml_cpBodyUpdateVelocity"

external cpBodyUpdatePosition : body:cpBody -> dt:float -> unit = "ml_cpBodyUpdatePosition"

external cpBodyLocal2World : body:cpBody -> v:cpVect -> cpVect = "ml_cpBodyLocal2World"

external cpBodyWorld2Local : body:cpBody -> v:cpVect -> cpVect = "ml_cpBodyWorld2Local"

external cpBodyApplyImpulse : body:cpBody -> j:cpVect -> r:cpVect -> unit = "ml_cpBodyApplyImpulse"

external cpBodyResetForces : body:cpBody -> unit = "ml_cpBodyResetForces"

external cpBodyApplyForce : body:cpBody -> f:cpVect -> r:cpVect -> unit = "ml_cpBodyApplyForce"

external cpBodyActivate : body:cpBody -> unit = "ml_cpBodyActivate"

external cpBodyActivateStatic : body:cpBody -> filter:cpShape -> unit = "ml_cpBodyActivateStatic"

external cpBodySleep : body:cpBody -> unit = "ml_cpBodySleep"

external cpBodyIsSleeping : body:cpBody -> bool = "ml_cpBodyIsSleeping"

external cpBodyIsStatic : body:cpBody -> bool = "ml_cpBodyIsStatic"

external cpBodyIsRogue : body:cpBody -> bool = "ml_cpBodyIsRogue"

external cpBodyGetVelAtWorldPoint : body:cpBody -> point:cpVect -> cpVect = "ml_cpBodyGetVelAtWorldPoint"

external cpBodyGetVelAtLocalPoint : body:cpBody -> point:cpVect -> cpVect = "ml_cpBodyGetVelAtLocalPoint"

external cpBodyKineticEnergy : body:cpBody -> float = "ml_cpBodyKineticEnergy"

external cpBodyGetMass : body:cpBody -> float = "ml_cpBodyGetMass"

external cpBodySetMass : body:cpBody -> m:float -> unit = "ml_cpBodySetMass"

external cpBodyGetMoment : body:cpBody -> float = "ml_cpBodyGetMoment"

external cpBodySetMoment : body:cpBody -> i:float -> unit = "ml_cpBodySetMoment"

external cpBodyGetPos : body:cpBody -> cpVect = "ml_cpBodyGetPos"

external cpBodySetPos : body:cpBody -> p:cpVect -> unit = "ml_cpBodySetPos"

external cpBodyGetVel : body:cpBody -> cpVect = "ml_cpBodyGetVel"

external cpBodySetVel : body:cpBody -> v:cpVect -> unit = "ml_cpBodySetVel"

external cpBodyGetForce : body:cpBody -> cpVect = "ml_cpBodyGetForce"

external cpBodySetForce : body:cpBody -> f:cpVect -> unit = "ml_cpBodySetForce"

external cpBodyGetAngle : body:cpBody -> float = "ml_cpBodyGetAngle"

external cpBodySetAngle : body:cpBody -> a:float -> unit = "ml_cpBodySetAngle"

external cpBodyGetAngVel : body:cpBody -> float = "ml_cpBodyGetAngVel"

external cpBodySetAngVel : body:cpBody -> w:float -> unit = "ml_cpBodySetAngVel"

external cpBodyGetTorque : body:cpBody -> float = "ml_cpBodyGetTorque"

external cpBodySetTorque : body:cpBody -> t:float -> unit = "ml_cpBodySetTorque"

external cpBodyGetRot : body:cpBody -> cpVect = "ml_cpBodyGetRot"

external cpBodyGetVelLimit : body:cpBody -> float = "ml_cpBodyGetVelLimit"

external cpBodySetVelLimit : body:cpBody -> v_limit:float -> unit = "ml_cpBodySetVelLimit"

external cpBodyGetAngVelLimit : body:cpBody -> float = "ml_cpBodyGetAngVelLimit"

external cpBodySetAngVelLimit : body:cpBody -> w_limit:float -> unit = "ml_cpBodySetAngVelLimit"

external cpShapeFree : shape:cpShape -> unit = "ml_cpShapeFree"

external cpResetShapeIdCounter : unit -> unit = "ml_cpResetShapeIdCounter"

external cpShapePointQuery : shape:cpShape -> p:cpVect -> bool = "ml_cpShapePointQuery"

external cpShapeGetSensor : shape:cpShape -> bool = "ml_cpShapeGetSensor"

external cpShapeSetSensor : shape:cpShape -> value:bool -> unit = "ml_cpShapeSetSensor"

external cpShapeGetElasticity : shape:cpShape -> float = "ml_cpShapeGetElasticity"

external cpShapeSetElasticity : shape:cpShape -> e:float -> unit = "ml_cpShapeSetElasticity"

external cpShapeGetFriction : shape:cpShape -> float = "ml_cpShapeGetFriction"

external cpShapeSetFriction : shape:cpShape -> u:float -> unit = "ml_cpShapeSetFriction"

external cpShapeGetSurfaceVelocity : shape:cpShape -> cpVect = "ml_cpShapeGetSurfaceVelocity"

external cpShapeSetSurfaceVelocity : shape:cpShape -> surface_v:cpVect -> unit = "ml_cpShapeSetSurfaceVelocity"

external cpShapeGetCollisionType : shape:cpShape -> int = "ml_cpShapeGetCollisionType"

external cpShapeSetCollisionType : shape:cpShape -> ct:int -> unit = "ml_cpShapeSetCollisionType"

external cpShapeGetLayers : shape:cpShape -> int = "ml_cpShapeGetLayers"

external cpShapeSetLayers : shape:cpShape -> layers:int -> unit = "ml_cpShapeSetLayers"

external cpPinJointNew : a:cpBody -> b:cpBody -> anchr1:cpVect -> anchr2:cpVect -> cpConstraint = "ml_cpPinJointNew"

external cpSlideJointNew : a:cpBody -> b:cpBody -> anchr1:cpVect -> anchr2:cpVect -> min:float -> max:float -> cpConstraint = "ml_cpSlideJointNew_bc" "ml_cpSlideJointNew"

external cpPivotJointNew : a:cpBody -> b:cpBody -> pivot:cpVect -> cpConstraint = "ml_cpPivotJointNew"

external cpPivotJointNew2 : a:cpBody -> b:cpBody -> anchr1:cpVect -> anchr2:cpVect -> cpConstraint = "ml_cpPivotJointNew2"

external cpGrooveJointNew : a:cpBody -> b:cpBody -> groove_a:cpVect -> groove_b:cpVect -> anchr2:cpVect -> cpConstraint = "ml_cpGrooveJointNew"

external cpConstraintFree : constr:cpConstraint -> unit = "ml_cpConstraintFree"

external cpDampedSpringNew : a:cpBody -> b:cpBody -> anchr1:cpVect -> anchr2:cpVect -> rest_length:float -> stiffness:float -> damping:float -> cpConstraint = "ml_cpDampedSpringNew_bc" "ml_cpDampedSpringNew"


(** {4 Structure Members Access} *)

external cpCircleShapeSetRadius: circle_shape:cpCircleShape -> r:float -> unit = "ml_cpCircleShapeSetRadius"

external cpCircleShapeSetCenter: circle_shape:cpCircleShape -> c:cpVect -> unit = "ml_cpCircleShapeSetCenter"

external cpSegmentShapeSetA: segment_shape:cpSegmentShape -> a:cpVect -> unit = "ml_cpSegmentShapeSetA"

external cpSegmentShapeSetB: segment_shape:cpSegmentShape -> b:cpVect -> unit = "ml_cpSegmentShapeSetB"

external cpSegmentShapeSetNorm: segment_shape:cpSegmentShape -> n:cpVect -> unit = "ml_cpSegmentShapeSetNorm"

external cpSegmentShapeSetThickness: segment_shape:cpSegmentShape -> r:float -> unit = "ml_cpSegmentShapeSetThickness"

external cpSegmentShapeSetTA: segment_shape:cpSegmentShape -> ta:cpVect -> unit = "ml_cpSegmentShapeSetTA"

external cpSegmentShapeSetTB: segment_shape:cpSegmentShape -> tb:cpVect -> unit = "ml_cpSegmentShapeSetTB"

external cpSegmentShapeSetTNorm: segment_shape:cpSegmentShape -> tn:cpVect -> unit = "ml_cpSegmentShapeSetTNorm"

external cpConstraintSetMaxForce: constr:cpConstraint -> maxForce:float -> unit = "ml_cpConstraintSetMaxForce"

external cpConstraintSetErrorBias: constr:cpConstraint -> errorBias:float -> unit = "ml_cpConstraintSetErrorBias"

external cpConstraintSetMaxBias: constr:cpConstraint -> maxBias:float -> unit = "ml_cpConstraintSetMaxBias"

external cpPinJointSetAnchor1: pin_joint:cpPinJoint -> anchr1:cpVect -> unit = "ml_cpPinJointSetAnchor1"

external cpPinJointSetAnchor2: pin_joint:cpPinJoint -> anchr2:cpVect -> unit = "ml_cpPinJointSetAnchor2"

external cpPinJointSetDist: pin_joint:cpPinJoint -> dist:float -> unit = "ml_cpPinJointSetDist"

external cpPinJointSetR1: pin_joint:cpPinJoint -> r1:cpVect -> unit = "ml_cpPinJointSetR1"

external cpPinJointSetR2: pin_joint:cpPinJoint -> r2:cpVect -> unit = "ml_cpPinJointSetR2"

external cpPinJointSetVect: pin_joint:cpPinJoint -> n:cpVect -> unit = "ml_cpPinJointSetVect"

external cpPinJointSetNMass: pin_joint:cpPinJoint -> nMass:float -> unit = "ml_cpPinJointSetNMass"

external cpPinJointSetJNAcc: pin_joint:cpPinJoint -> jnAcc:float -> unit = "ml_cpPinJointSetJNAcc"

external cpPinJointSetBias: pin_joint:cpPinJoint -> bias:float -> unit = "ml_cpPinJointSetBias"

external cpSlideJointSetAnchor1: slide_joint:cpSlideJoint -> anchr1:cpVect -> unit = "ml_cpSlideJointSetAnchor1"

external cpSlideJointSetAnchor2: slide_joint:cpSlideJoint -> anchr2:cpVect -> unit = "ml_cpSlideJointSetAnchor2"

external cpSlideJointSetMin: slide_joint:cpSlideJoint -> min:float -> unit = "ml_cpSlideJointSetMin"

external cpSlideJointSetMax: slide_joint:cpSlideJoint -> max:float -> unit = "ml_cpSlideJointSetMax"

external cpSlideJointSetR1: slide_joint:cpSlideJoint -> r1:cpVect -> unit = "ml_cpSlideJointSetR1"

external cpSlideJointSetR2: slide_joint:cpSlideJoint -> r2:cpVect -> unit = "ml_cpSlideJointSetR2"

external cpSlideJointSetVect: slide_joint:cpSlideJoint -> n:cpVect -> unit = "ml_cpSlideJointSetVect"

external cpSlideJointSetNMass: slide_joint:cpSlideJoint -> nMass:float -> unit = "ml_cpSlideJointSetNMass"

external cpSlideJointSetJNAcc: slide_joint:cpSlideJoint -> jnAcc:float -> unit = "ml_cpSlideJointSetJNAcc"

external cpSlideJointSetBias: slide_joint:cpSlideJoint -> bias:float -> unit = "ml_cpSlideJointSetBias"

external cpPivotJointSetAnchor1: pivot_joint:cpPivotJoint -> anchr1:cpVect -> unit = "ml_cpPivotJointSetAnchor1"

external cpPivotJointSetAnchor2: pivot_joint:cpPivotJoint -> anchr2:cpVect -> unit = "ml_cpPivotJointSetAnchor2"

external cpPivotJointSetR1: pivot_joint:cpPivotJoint -> r1:cpVect -> unit = "ml_cpPivotJointSetR1"

external cpPivotJointSetR2: pivot_joint:cpPivotJoint -> r2:cpVect -> unit = "ml_cpPivotJointSetR2"

external cpPivotJointSetJAcc: pivot_joint:cpPivotJoint -> jAcc:cpVect -> unit = "ml_cpPivotJointSetJAcc"

external cpPivotJointSetBias: pivot_joint:cpPivotJoint -> bias:cpVect -> unit = "ml_cpPivotJointSetBias"

external cpGrooveJointSetGrvN: groove_joint:cpGrooveJoint -> grv_n:cpVect -> unit = "ml_cpGrooveJointSetGrvN"

external cpGrooveJointSetGrvA: groove_joint:cpGrooveJoint -> grv_a:cpVect -> unit = "ml_cpGrooveJointSetGrvA"

external cpGrooveJointSetGrvB: groove_joint:cpGrooveJoint -> grv_b:cpVect -> unit = "ml_cpGrooveJointSetGrvB"

external cpGrooveJointSetAnchor2: groove_joint:cpGrooveJoint -> anchr2:cpVect -> unit = "ml_cpGrooveJointSetAnchor2"

external cpGrooveJointSetGrvTn: groove_joint:cpGrooveJoint -> grv_tn:cpVect -> unit = "ml_cpGrooveJointSetGrvTn"

external cpGrooveJointSetClamp: groove_joint:cpGrooveJoint -> clamp:float -> unit = "ml_cpGrooveJointSetClamp"

external cpGrooveJointSetR1: groove_joint:cpGrooveJoint -> r1:cpVect -> unit = "ml_cpGrooveJointSetR1"

external cpGrooveJointSetR2: groove_joint:cpGrooveJoint -> r2:cpVect -> unit = "ml_cpGrooveJointSetR2"

external cpGrooveJointSetJAcc: groove_joint:cpGrooveJoint -> jAcc:cpVect -> unit = "ml_cpGrooveJointSetJAcc"

external cpGrooveJointSetBias: groove_joint:cpGrooveJoint -> bias:cpVect -> unit = "ml_cpGrooveJointSetBias"

external cpArbiterSetE: arbiter:cpArbiter -> e:float -> unit = "ml_cpArbiterSetE"

external cpArbiterSetU: arbiter:cpArbiter -> u:float -> unit = "ml_cpArbiterSetU"

external cpArbiterSetSurface_vr: arbiter:cpArbiter -> surface_vr:cpVect -> unit = "ml_cpArbiterSetSurface_vr"

external cpBBSetL: bb:cpBB -> l:float -> unit = "ml_cpBBSetL"

external cpBBSetB: bb:cpBB -> b:float -> unit = "ml_cpBBSetB"

external cpBBSetR: bb:cpBB -> r:float -> unit = "ml_cpBBSetR"

external cpBBSetT: bb:cpBB -> t:float -> unit = "ml_cpBBSetT"

external cpCircleShapeGetRadius: circle_shape:cpCircleShape -> float = "ml_cpCircleShapeGetRadius"

external cpCircleShapeGetCenter: circle_shape:cpCircleShape -> cpVect = "ml_cpCircleShapeGetCenter"

external cpSegmentShapeGetA: segment_shape:cpSegmentShape -> cpVect = "ml_cpSegmentShapeGetA"

external cpSegmentShapeGetB: segment_shape:cpSegmentShape -> cpVect = "ml_cpSegmentShapeGetB"

external cpSegmentShapeGetNorm: segment_shape:cpSegmentShape -> cpVect = "ml_cpSegmentShapeGetNorm"

external cpSegmentShapeGetThickness: segment_shape:cpSegmentShape -> float = "ml_cpSegmentShapeGetThickness"

external cpSegmentShapeGetTA: segment_shape:cpSegmentShape -> cpVect = "ml_cpSegmentShapeGetTA"

external cpSegmentShapeGetTB: segment_shape:cpSegmentShape -> cpVect = "ml_cpSegmentShapeGetTB"

external cpSegmentShapeGetTNorm: segment_shape:cpSegmentShape -> cpVect = "ml_cpSegmentShapeGetTNorm"

external cpPolyShapeGetNumVerts: poly:cpPolyShape -> int = "ml_cpPolyShapeGetNumVerts"

external cpPolyShapeGetVects: poly:cpPolyShape -> cpVectArray = "ml_cpPolyShapeGetVects"

external cpPolyShapeGetTVerts: poly:cpPolyShape -> cpVectArray = "ml_cpPolyShapeGetTVerts"

external cpConstraintGetMaxForce: constr:cpConstraint -> float = "ml_cpConstraintGetMaxForce"

external cpConstraintGetErrorBias: constr:cpConstraint -> float = "ml_cpConstraintGetErrorBias"

external cpConstraintGetMaxBias: constr:cpConstraint -> float = "ml_cpConstraintGetMaxBias"

external cpPinJointGetAnchor1: pin_joint:cpPinJoint -> cpVect = "ml_cpPinJointGetAnchor1"

external cpPinJointGetAnchor2: pin_joint:cpPinJoint -> cpVect = "ml_cpPinJointGetAnchor2"

external cpPinJointGetDist: pin_joint:cpPinJoint -> float = "ml_cpPinJointGetDist"

external cpPinJointGetR1: pin_joint:cpPinJoint -> cpVect = "ml_cpPinJointGetR1"

external cpPinJointGetR2: pin_joint:cpPinJoint -> cpVect = "ml_cpPinJointGetR2"

external cpPinJointGetVect: pin_joint:cpPinJoint -> cpVect = "ml_cpPinJointGetVect"

external cpPinJointGetNMass: pin_joint:cpPinJoint -> float = "ml_cpPinJointGetNMass"

external cpPinJointGetJNAcc: pin_joint:cpPinJoint -> float = "ml_cpPinJointGetJNAcc"

external cpPinJointGetBias: pin_joint:cpPinJoint -> float = "ml_cpPinJointGetBias"

external cpSlideJointGetAnchor1: slide_joint:cpSlideJoint -> cpVect = "ml_cpSlideJointGetAnchor1"

external cpSlideJointGetAnchor2: slide_joint:cpSlideJoint -> cpVect = "ml_cpSlideJointGetAnchor2"

external cpSlideJointGetMin: slide_joint:cpSlideJoint -> float = "ml_cpSlideJointGetMin"

external cpSlideJointGetMax: slide_joint:cpSlideJoint -> float = "ml_cpSlideJointGetMax"

external cpSlideJointGetR1: slide_joint:cpSlideJoint -> cpVect = "ml_cpSlideJointGetR1"

external cpSlideJointGetR2: slide_joint:cpSlideJoint -> cpVect = "ml_cpSlideJointGetR2"

external cpSlideJointGetVect: slide_joint:cpSlideJoint -> cpVect = "ml_cpSlideJointGetVect"

external cpSlideJointGetNMass: slide_joint:cpSlideJoint -> float = "ml_cpSlideJointGetNMass"

external cpSlideJointGetJNAcc: slide_joint:cpSlideJoint -> float = "ml_cpSlideJointGetJNAcc"

external cpSlideJointGetBias: slide_joint:cpSlideJoint -> float = "ml_cpSlideJointGetBias"

external cpPivotJointGetAnchor1: pivot_joint:cpPivotJoint -> cpVect = "ml_cpPivotJointGetAnchor1"

external cpPivotJointGetAnchor2: pivot_joint:cpPivotJoint -> cpVect = "ml_cpPivotJointGetAnchor2"

external cpPivotJointGetR1: pivot_joint:cpPivotJoint -> cpVect = "ml_cpPivotJointGetR1"

external cpPivotJointGetR2: pivot_joint:cpPivotJoint -> cpVect = "ml_cpPivotJointGetR2"

external cpPivotJointGetJAcc: pivot_joint:cpPivotJoint -> cpVect = "ml_cpPivotJointGetJAcc"

external cpPivotJointGetBias: pivot_joint:cpPivotJoint -> cpVect = "ml_cpPivotJointGetBias"

external cpGrooveJointGetGrvN: groove_joint:cpGrooveJoint -> cpVect = "ml_cpGrooveJointGetGrvN"

external cpGrooveJointGetGrvA: groove_joint:cpGrooveJoint -> cpVect = "ml_cpGrooveJointGetGrvA"

external cpGrooveJointGetGrvB: groove_joint:cpGrooveJoint -> cpVect = "ml_cpGrooveJointGetGrvB"

external cpGrooveJointGetAnchor2: groove_joint:cpGrooveJoint -> cpVect = "ml_cpGrooveJointGetAnchor2"

external cpGrooveJointGetGrvTn: groove_joint:cpGrooveJoint -> cpVect = "ml_cpGrooveJointGetGrvTn"

external cpGrooveJointGetClamp: groove_joint:cpGrooveJoint -> float = "ml_cpGrooveJointGetClamp"

external cpGrooveJointGetR1: groove_joint:cpGrooveJoint -> cpVect = "ml_cpGrooveJointGetR1"

external cpGrooveJointGetR2: groove_joint:cpGrooveJoint -> cpVect = "ml_cpGrooveJointGetR2"

external cpGrooveJointGetJAcc: groove_joint:cpGrooveJoint -> cpVect = "ml_cpGrooveJointGetJAcc"

external cpGrooveJointGetBias: groove_joint:cpGrooveJoint -> cpVect = "ml_cpGrooveJointGetBias"

external cpArbiterGetE: arbiter:cpArbiter -> float = "ml_cpArbiterGetE"

external cpArbiterGetU: arbiter:cpArbiter -> float = "ml_cpArbiterGetU"

external cpArbiterGetSurface_vr: arbiter:cpArbiter -> cpVect = "ml_cpArbiterGetSurface_vr"

external cpBBGetL: bb:cpBB -> float = "ml_cpBBGetL"

external cpBBGetB: bb:cpBB -> float = "ml_cpBBGetB"

external cpBBGetR: bb:cpBB -> float = "ml_cpBBGetR"

external cpBBGetT: bb:cpBB -> float = "ml_cpBBGetT"
# 262 "chipmunk.ml.pp" 2


# 265 "chipmunk.ml.pp"
val cpSpaceAddCollisionHandler : space:cpSpace -> a:int -> b:int -> data:string -> unit
# 271 "chipmunk.ml.pp"


end
(* }}} *)

# 277 "chipmunk.ml.pp"

(** {2 High Level, Object Oriented, Interface} *)
(* {{{ generated sig *)
module OO :
  sig
    val init_chipmunk : unit -> unit
    val moment_for_circle :
      m:float -> r1:float -> r2:float -> offset:Low_level.cpVect -> float
(** Calculate the moment of inertia for a circle with the given mass, inner and
    outer radii, and offset. *)
    val moment_for_poly :
      m:float ->
      verts:Low_level.cpVect array -> offset:Low_level.cpVect -> float
(** Calculate the moment of inertia for a polygon with the given mass, vertexes,
    and offset. verts should be an array of cpVect with a counterclockwise
    winding, offset should be a cpVect. *)
    class virtual cp_body_virt :
      Low_level.cpBody ->
      object
        val body : Low_level.cpBody
        method virtual apply_force :
          f:Low_level.cpVect -> r:Low_level.cpVect -> unit
        method virtual apply_impulse :
          j:Low_level.cpVect -> r:Low_level.cpVect -> unit
        method virtual body : Low_level.cpBody
        method virtual free : unit
        method virtual get_a_vel : float
        method virtual get_angle : float
        method virtual get_force : Low_level.cpVect
        method virtual get_mass : float
        method virtual get_moment : float
        method virtual get_pos : Low_level.cpVect
        method virtual get_rot : Low_level.cpVect
        method virtual get_torque : float
        method virtual get_vel : Low_level.cpVect
        method virtual local2world : v:Low_level.cpVect -> Low_level.cpVect
        method virtual reset_forces : unit
        method virtual set_a_vel : w:float -> unit
        method virtual set_angle : a:float -> unit
        method virtual set_force : f:Low_level.cpVect -> unit
        method virtual set_mass : m:float -> unit
        method virtual set_moment : i:float -> unit
        method virtual set_pos : p:Low_level.cpVect -> unit
        (*
        method virtual set_rot : rot:Low_level.cpVect -> unit
        *)
        method virtual set_vel_lim     : v_limit:float -> unit
        method virtual set_ang_vel_lim : w_limit:float -> unit
        method virtual set_torque : t:float -> unit
        method virtual set_vel : v:Low_level.cpVect -> unit
        method virtual update_position : dt:float -> unit
        method virtual update_velocity :
          gravity:Low_level.cpVect -> damping:float -> dt:float -> unit
        method virtual world2local : v:Low_level.cpVect -> Low_level.cpVect
      end
    class cp_body :
      m:float ->
      i:float ->
      object
        val body : Low_level.cpBody
        method apply_force : f:Low_level.cpVect -> r:Low_level.cpVect -> unit
        method apply_impulse :
          j:Low_level.cpVect -> r:Low_level.cpVect -> unit
        method body : Low_level.cpBody
        method free : unit
        method get_a_vel : float
        method get_angle : float
        method get_force : Low_level.cpVect
        method get_mass : float
        method get_moment : float
        method get_pos : Low_level.cpVect
        method get_rot : Low_level.cpVect
        method get_torque : float
        method get_vel : Low_level.cpVect
        method local2world : v:Low_level.cpVect -> Low_level.cpVect
        method reset_forces : unit
        method set_a_vel : w:float -> unit
        method set_angle : a:float -> unit
        method set_force : f:Low_level.cpVect -> unit
        method set_mass : m:float -> unit
        method set_moment : i:float -> unit
        method set_pos : p:Low_level.cpVect -> unit
        (*
        method set_rot : rot:Low_level.cpVect -> unit
        *)
        method set_vel_lim     : v_limit:float -> unit
        method set_ang_vel_lim : w_limit:float -> unit
        method set_torque : t:float -> unit
        method set_vel : v:Low_level.cpVect -> unit
        method update_position : dt:float -> unit
        method update_velocity :
          gravity:Low_level.cpVect -> damping:float -> dt:float -> unit
        method world2local : v:Low_level.cpVect -> Low_level.cpVect
      end

    val to_cp_body : body:Low_level.cpBody -> cp_body_virt

    exception Wrong_joint_kind

(** parameters to create a new [cp_joint]. *)
    type joint_kind =
        PIN_JOINT of Low_level.cpVect * Low_level.cpVect                       (** anchor1, anchor2 *)
      | SLIDE_JOINT of Low_level.cpVect * Low_level.cpVect * float * float     (** anchor1, anchor2, min, max *)
      | PIVOT_JOINT of Low_level.cpVect                                        (** pivot *)
      | GROOVE_JOINT of Low_level.cpVect * Low_level.cpVect * Low_level.cpVect (** groove_a, groove_b, anchor2 *)
(**
  [anchor1] and [anchor2] are the anchor points on those bodies.

  [anchor1] and [anchor2] are the anchor points on those bodies, and [min] and
  [max] define the allowed distances of the anchor points.

  [pivot] is the point in world coordinates of the pivot.
  Because the pivot location is given in world coordinates, you must have the
  bodies moved into the correct positions already.

  The groove goes from [groove_a] to [groove_b] on body [a], and the pivot is
  attached to [anchor2] on body [b]. All coordinates are body local.
*)


(** [a] and [b] are the two bodies to connect. *)
    class cp_joint :
      a:cp_body_virt ->
      b:cp_body_virt ->
      kind:joint_kind ->
      object
        val constr : Low_level.cpConstraint
        val kind : Low_level.cpJointType
        method free : unit
        (*
        method get_groove_joint : cp_groove_joint
        method get_pin_joint : cp_pin_joint
        method get_pivot_joint : cp_pivot_joint
        method get_slide_joint : cp_slide_joint
        *)
        method get_constraint : Low_level.cpConstraint

        method is_groove_joint : bool
        method is_pin_joint : bool
        method is_pivot_joint : bool
        method is_slide_joint : bool
        method constr : Low_level.cpConstraint
        method kind : Low_level.cpJointType
      end


    val reset_shape_id_counter : unit -> unit
    exception Wrong_shape_kind
    class cp_circle_shape :
      shape:< shape : Low_level.cpShape; .. > ->
      object
        val circle_shape : Low_level.cpCircleShape
        method get_center : Low_level.cpVect
        method get_radius : float
        method set_center : c:Low_level.cpVect -> unit
        method set_radius : r:float -> unit
      end
    class cp_segment_shape :
      shape:< shape : Low_level.cpShape; .. > ->
      object
        val segment_shape : Low_level.cpSegmentShape
        method get_a : Low_level.cpVect
        method get_b : Low_level.cpVect
        method get_norm : Low_level.cpVect
        method get_t_a : Low_level.cpVect
        method get_t_b : Low_level.cpVect
        method get_t_norm : Low_level.cpVect
        method get_thick : float
        method set_a : a:Low_level.cpVect -> unit
        method set_b : b:Low_level.cpVect -> unit
        method set_norm : n:Low_level.cpVect -> unit
        method set_t_a : ta:Low_level.cpVect -> unit
        method set_t_b : tb:Low_level.cpVect -> unit
        method set_t_norm : tn:Low_level.cpVect -> unit
        method set_thick : r:float -> unit
      end
    class cp_poly_shape :
      shape:< shape : Low_level.cpShape; .. > ->
      object
        val poly : Low_level.cpPolyShape
        method get_num_verts : int
        method get_t_verts : Low_level.cpVectArray
        method get_verts : Low_level.cpVectArray
      end
    class virtual cp_shape_virt :
      Low_level.cpShape ->
      object
        val shape : Low_level.cpShape
        method virtual body : cp_body_virt
        method virtual free : unit
        method virtual get_circle_shape : cp_circle_shape
        method virtual get_elasticity : float
        method virtual get_friction : float
        method virtual get_layers : int
        method virtual get_poly_shape : cp_poly_shape
        method virtual get_segment_shape : cp_segment_shape
        method virtual get_surface_vel : Low_level.cpVect
        (*
        method virtual is_circle_shape : bool
        method virtual is_poly_shape : bool
        method virtual is_segment_shape : bool
        method virtual kind : Low_level.cpShapeType
        *)
        (*
        method virtual set_collision_type : collision_type:int -> unit
        method virtual get_collision_type : int
        *)
        (*
        method virtual get_group : int
        method virtual set_group : group:int -> unit
        *)
        method virtual set_elasticity : e:float -> unit
        method virtual set_friction : u:float -> unit
        method virtual set_layers : layers:int -> unit
        method virtual set_surface_vel : surface_vel:Low_level.cpVect -> unit
        method virtual shape : Low_level.cpShape
      end
(** parameter for each shape kind *)
    type shape_kind =
        CIRCLE_SHAPE of float * Low_level.cpVect                       (** radius, center *)
      | SEGMENT_SHAPE of Low_level.cpVect * Low_level.cpVect * float   (** a, b, thickness *)
      | POLY_SHAPE of Low_level.cpVect array * Low_level.cpVect        (** verts, offset *)
    class cp_shape :
      body:cp_body_virt ->
      kind:shape_kind ->
      object
        val shape : Low_level.cpShape
        method body : cp_body_virt
        method free : unit
        method get_circle_shape : cp_circle_shape
        (*
        method get_collision_type : int
        *)
        method get_elasticity : float
        method get_friction : float
        method get_layers : int
        method get_poly_shape : cp_poly_shape
        method get_segment_shape : cp_segment_shape
        method get_surface_vel : Low_level.cpVect
    (** Surface velocity used when solving for friction. *)
        (*
        method is_circle_shape : bool
        method is_poly_shape : bool
        method is_segment_shape : bool
        method kind : Low_level.cpShapeType
        *)
        (*
        method set_collision_type : collision_type:int -> unit
        *)
    (** User defined collision type for the shape. *)
        method set_elasticity : e:float -> unit
    (** Coefficient of restitution. (elasticity) *)
        method set_friction : u:float -> unit
    (** Coefficient of friction. *)
        (*
        method get_group : int
        method set_group : group:int -> unit
    (** User defined collision group for the shape. *)
        *)
        method set_layers : layers:int -> unit
    (** User defined layer bitmask for the shape. *)
        method set_surface_vel : surface_vel:Low_level.cpVect -> unit
        method shape : Low_level.cpShape
      end
    val to_cp_shape : shape:Low_level.cpShape -> cp_shape_virt
    class cp_space :
      object
        val space : Low_level.cpSpace
        method add_body : body:cp_body_virt -> unit
        method add_shape : shape:cp_shape_virt -> unit
    (** Add the given shape to the space's active spatial hash. Shapes attached to
        moving bodies should be added here as they will be rehashed on every call
        to [space#step]. *)
        method add_static_shape : shape:cp_shape_virt -> unit
        method add_constraint : constr:Low_level.cpConstraint -> unit
    (** Add the given shape to the space's static spatial hash. *)
        method free : unit
        method get_damping : float
        method get_gravity : Low_level.cpVect
        method get_iterations : int
        method remove_body : body:cp_body_virt -> unit
        method remove_shape : shape:cp_shape_virt -> unit
        method remove_static_shape : shape:cp_shape_virt -> unit
        method remove_constraint : constr:Low_level.cpConstraint -> unit
        method set_damping : damping:float -> unit
    (** The amount of damping to apply to the system when updating. *)
        method set_gravity : gravity:Low_level.cpVect -> unit
    (** The amount of gravity in the system. *)
        method set_iterations : iterations:int -> unit
    (** The number of iterations to use when solving constraints. (collisions and joints) *)
        method space : Low_level.cpSpace
        method step : dt:float -> unit
    (** Move the space forward by dt seconds. Using a fixed size time step is
        {i highly} recommended for efficiency of the contact persistence algorithm. *)

    (**
      {b Notes:}

      When removing objects from the space, make sure you remove any other objects that
      reference it. For instance, when you remove a body, remove the joints and shapes
      attached to it.

      The number of iterations, and the size of the time step determine the quality of
      the simulation. More iterations, or smaller time steps increase the quality.
    *)
      end

    val damped_spring :
      a:cp_body_virt ->
      b:cp_body_virt ->
      anchr1:Low_level.cpVect ->
      anchr2:Low_level.cpVect ->
      rest_length:float -> stiffness:float -> damping:float -> Low_level.cpConstraint
(** Apply a spring force between bodies a and b at anchors anchr1 and anchr2
    respectively. k is the spring constant (force/distance), rlen is the rest
    length of the spring, dmp is the damping constant (force/velocity), and dt
    is the time step to apply the force over. Note: not solving the damping
    forces in the impulse solver causes problems with large damping values. This
    function will eventually be replaced by a new constraint (joint) type. *)

  end
(* }}} end of module OO *)

# 1228 "chipmunk.ml.pp"


(* vim: sw=2 sts=2 ts=2 et filetype=ocaml fdm=marker
 *)
