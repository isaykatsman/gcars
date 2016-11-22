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
