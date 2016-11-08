// This is a generated file
#include "wrap_chipmunk.h"

CAMLprim value
ml_cpAreaForCircle( value r1, value r2 )
{
    cpFloat _ret = cpAreaForCircle( Double_val(r1), Double_val(r2) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpMomentForSegment( value m, value ml_a, value ml_b )
{
    cpVect a;
    a.x = Double_field(ml_a,0);
    a.y = Double_field(ml_a,1);

    cpVect b;
    b.x = Double_field(ml_b,0);
    b.y = Double_field(ml_b,1);

    cpFloat _ret = cpMomentForSegment( Double_val(m), a, b );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpAreaForSegment( value ml_a, value ml_b, value r )
{
    cpVect a;
    a.x = Double_field(ml_a,0);
    a.y = Double_field(ml_a,1);

    cpVect b;
    b.x = Double_field(ml_b,0);
    b.y = Double_field(ml_b,1);

    cpFloat _ret = cpAreaForSegment( a, b, Double_val(r) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpMomentForBox( value m, value width, value height )
{
    cpFloat _ret = cpMomentForBox( Double_val(m), Double_val(width), Double_val(height) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpSpaceDestroy( value space )
{
    cpSpaceDestroy( cpSpace_val(space) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceFree( value space )
{
    cpSpaceFree( cpSpace_val(space) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceAddShape( value space, value shape )
{
    cpSpaceAddShape( cpSpace_val(space), cpShape_val(shape) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceAddStaticShape( value space, value shape )
{
    cpSpaceAddStaticShape( cpSpace_val(space), cpShape_val(shape) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceAddBody( value space, value body )
{
    cpSpaceAddBody( cpSpace_val(space), cpBody_val(body) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceAddConstraint( value space, value constr )
{
    cpSpaceAddConstraint( cpSpace_val(space), cpConstraint_val(constr) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceRemoveShape( value space, value shape )
{
    cpSpaceRemoveShape( cpSpace_val(space), cpShape_val(shape) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceRemoveStaticShape( value space, value shape )
{
    cpSpaceRemoveStaticShape( cpSpace_val(space), cpShape_val(shape) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceRemoveBody( value space, value body )
{
    cpSpaceRemoveBody( cpSpace_val(space), cpBody_val(body) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceRemoveConstraint( value space, value constr )
{
    cpSpaceRemoveConstraint( cpSpace_val(space), cpConstraint_val(constr) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceStep( value space, value dt )
{
    cpSpaceStep( cpSpace_val(space), Double_val(dt) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceIsLocked( value space )
{
    cpBool _ret = cpSpaceIsLocked( cpSpace_val(space) );
    return Val_bool(_ret);
}


CAMLprim value
ml_cpSpaceContainsShape( value space, value shape )
{
    cpBool _ret = cpSpaceContainsShape( cpSpace_val(space), cpShape_val(shape) );
    return Val_bool(_ret);
}


CAMLprim value
ml_cpSpaceContainsBody( value space, value body )
{
    cpBool _ret = cpSpaceContainsBody( cpSpace_val(space), cpBody_val(body) );
    return Val_bool(_ret);
}


CAMLprim value
ml_cpSpaceContainsConstraint( value space, value constr )
{
    cpBool _ret = cpSpaceContainsConstraint( cpSpace_val(space), cpConstraint_val(constr) );
    return Val_bool(_ret);
}


CAMLprim value
ml_cpSpaceReindexStatic( value space )
{
    cpSpaceReindexStatic( cpSpace_val(space) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceReindexShape( value space, value shape )
{
    cpSpaceReindexShape( cpSpace_val(space), cpShape_val(shape) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceReindexShapesForBody( value space, value body )
{
    cpSpaceReindexShapesForBody( cpSpace_val(space), cpBody_val(body) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceUseSpatialHash( value space, value dim, value count )
{
    cpSpaceUseSpatialHash( cpSpace_val(space), Double_val(dim), Int_val(count) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceRemoveCollisionHandler( value space, value a, value b )
{
    cpSpaceRemoveCollisionHandler( cpSpace_val(space), Int_val(a), Int_val(b) );
    return Val_unit;
}


CAMLprim value
ml_my_cpSpaceSetDefaultCollisionHandler( value space, value data )
{
    my_cpSpaceSetDefaultCollisionHandler( cpSpace_val(space), String_val(data) );
    return Val_unit;
}


CAMLprim value
ml_my_cpSpaceAddCollisionHandler( value space, value a, value b, value data )
{
    my_cpSpaceAddCollisionHandler( cpSpace_val(space), Int_val(a), Int_val(b), String_val(data) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceGetIterations( value space )
{
    int _ret = cpSpaceGetIterations( cpSpace_val(space) );
    return Val_long(_ret);
}


CAMLprim value
ml_cpSpaceSetIterations( value space, value iterations )
{
    cpSpaceSetIterations( cpSpace_val(space), Int_val(iterations) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceGetGravity( value space )
{
    CAMLparam0();
    CAMLlocal1( ml_ret );

    cpVect _ret = cpSpaceGetGravity( cpSpace_val(space) );
    
    ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);

    Store_double_field( ml_ret, 0, _ret.x );
    Store_double_field( ml_ret, 1, _ret.y );

    CAMLreturn( ml_ret );
}


CAMLprim value
ml_cpSpaceSetGravity( value space, value ml_gravity )
{
    cpVect gravity;
    gravity.x = Double_field(ml_gravity,0);
    gravity.y = Double_field(ml_gravity,1);

    cpSpaceSetGravity( cpSpace_val(space), gravity );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceGetDamping( value space )
{
    cpFloat _ret = cpSpaceGetDamping( cpSpace_val(space) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpSpaceSetDamping( value space, value damping )
{
    cpSpaceSetDamping( cpSpace_val(space), Double_val(damping) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceGetIdleSpeedThreshold( value space )
{
    cpFloat _ret = cpSpaceGetIdleSpeedThreshold( cpSpace_val(space) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpSpaceSetIdleSpeedThreshold( value space, value v )
{
    cpSpaceSetIdleSpeedThreshold( cpSpace_val(space), Double_val(v) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceGetSleepTimeThreshold( value space )
{
    cpFloat _ret = cpSpaceGetSleepTimeThreshold( cpSpace_val(space) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpSpaceSetSleepTimeThreshold( value space, value v )
{
    cpSpaceSetSleepTimeThreshold( cpSpace_val(space), Double_val(v) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceGetCollisionSlop( value space )
{
    cpFloat _ret = cpSpaceGetCollisionSlop( cpSpace_val(space) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpSpaceSetCollisionSlop( value space, value v )
{
    cpSpaceSetCollisionSlop( cpSpace_val(space), Double_val(v) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceGetCollisionBias( value space )
{
    cpFloat _ret = cpSpaceGetCollisionBias( cpSpace_val(space) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpSpaceSetCollisionBias( value space, value v )
{
    cpSpaceSetCollisionBias( cpSpace_val(space), Double_val(v) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceGetEnableContactGraph( value space )
{
    cpBool _ret = cpSpaceGetEnableContactGraph( cpSpace_val(space) );
    return Val_bool(_ret);
}


CAMLprim value
ml_cpSpaceSetEnableContactGraph( value space, value v )
{
    cpSpaceSetEnableContactGraph( cpSpace_val(space), Bool_val(v) );
    return Val_unit;
}


CAMLprim value
ml_cpSpaceGetCurrentTimeStep( value space )
{
    cpFloat _ret = cpSpaceGetCurrentTimeStep( cpSpace_val(space) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpBodyFree( value body )
{
    cpBodyFree( cpBody_val(body) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyUpdateVelocity( value body, value ml_gravity, value damping, value dt )
{
    cpVect gravity;
    gravity.x = Double_field(ml_gravity,0);
    gravity.y = Double_field(ml_gravity,1);

    cpBodyUpdateVelocity( cpBody_val(body), gravity, Double_val(damping), Double_val(dt) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyUpdatePosition( value body, value dt )
{
    cpBodyUpdatePosition( cpBody_val(body), Double_val(dt) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyLocal2World( value body, value ml_v )
{
    CAMLparam0();
    CAMLlocal1( ml_ret );

    cpVect v;
    v.x = Double_field(ml_v,0);
    v.y = Double_field(ml_v,1);

    cpVect _ret = cpBodyLocal2World( cpBody_val(body), v );
    
    ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);

    Store_double_field( ml_ret, 0, _ret.x );
    Store_double_field( ml_ret, 1, _ret.y );

    CAMLreturn( ml_ret );
}


CAMLprim value
ml_cpBodyWorld2Local( value body, value ml_v )
{
    CAMLparam0();
    CAMLlocal1( ml_ret );

    cpVect v;
    v.x = Double_field(ml_v,0);
    v.y = Double_field(ml_v,1);

    cpVect _ret = cpBodyWorld2Local( cpBody_val(body), v );
    
    ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);

    Store_double_field( ml_ret, 0, _ret.x );
    Store_double_field( ml_ret, 1, _ret.y );

    CAMLreturn( ml_ret );
}


CAMLprim value
ml_cpBodyApplyImpulse( value body, value ml_j, value ml_r )
{
    cpVect j;
    j.x = Double_field(ml_j,0);
    j.y = Double_field(ml_j,1);

    cpVect r;
    r.x = Double_field(ml_r,0);
    r.y = Double_field(ml_r,1);

    cpBodyApplyImpulse( cpBody_val(body), j, r );
    return Val_unit;
}


CAMLprim value
ml_cpBodyResetForces( value body )
{
    cpBodyResetForces( cpBody_val(body) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyApplyForce( value body, value ml_f, value ml_r )
{
    cpVect f;
    f.x = Double_field(ml_f,0);
    f.y = Double_field(ml_f,1);

    cpVect r;
    r.x = Double_field(ml_r,0);
    r.y = Double_field(ml_r,1);

    cpBodyApplyForce( cpBody_val(body), f, r );
    return Val_unit;
}


CAMLprim value
ml_cpBodyActivate( value body )
{
    cpBodyActivate( cpBody_val(body) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyActivateStatic( value body, value filter )
{
    cpBodyActivateStatic( cpBody_val(body), cpShape_val(filter) );
    return Val_unit;
}


CAMLprim value
ml_cpBodySleep( value body )
{
    cpBodySleep( cpBody_val(body) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyIsSleeping( value body )
{
    cpBool _ret = cpBodyIsSleeping( cpBody_val(body) );
    return Val_bool(_ret);
}


CAMLprim value
ml_cpBodyIsStatic( value body )
{
    cpBool _ret = cpBodyIsStatic( cpBody_val(body) );
    return Val_bool(_ret);
}


CAMLprim value
ml_cpBodyIsRogue( value body )
{
    cpBool _ret = cpBodyIsRogue( cpBody_val(body) );
    return Val_bool(_ret);
}


CAMLprim value
ml_cpBodyGetVelAtWorldPoint( value body, value ml_point )
{
    CAMLparam0();
    CAMLlocal1( ml_ret );

    cpVect point;
    point.x = Double_field(ml_point,0);
    point.y = Double_field(ml_point,1);

    cpVect _ret = cpBodyGetVelAtWorldPoint( cpBody_val(body), point );
    
    ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);

    Store_double_field( ml_ret, 0, _ret.x );
    Store_double_field( ml_ret, 1, _ret.y );

    CAMLreturn( ml_ret );
}


CAMLprim value
ml_cpBodyGetVelAtLocalPoint( value body, value ml_point )
{
    CAMLparam0();
    CAMLlocal1( ml_ret );

    cpVect point;
    point.x = Double_field(ml_point,0);
    point.y = Double_field(ml_point,1);

    cpVect _ret = cpBodyGetVelAtLocalPoint( cpBody_val(body), point );
    
    ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);

    Store_double_field( ml_ret, 0, _ret.x );
    Store_double_field( ml_ret, 1, _ret.y );

    CAMLreturn( ml_ret );
}


CAMLprim value
ml_cpBodyKineticEnergy( value body )
{
    cpFloat _ret = cpBodyKineticEnergy( cpBody_val(body) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpBodyGetMass( value body )
{
    cpFloat _ret = cpBodyGetMass( cpBody_val(body) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpBodySetMass( value body, value m )
{
    cpBodySetMass( cpBody_val(body), Double_val(m) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyGetMoment( value body )
{
    cpFloat _ret = cpBodyGetMoment( cpBody_val(body) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpBodySetMoment( value body, value i )
{
    cpBodySetMoment( cpBody_val(body), Double_val(i) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyGetPos( value body )
{
    CAMLparam0();
    CAMLlocal1( ml_ret );

    cpVect _ret = cpBodyGetPos( cpBody_val(body) );
    
    ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);

    Store_double_field( ml_ret, 0, _ret.x );
    Store_double_field( ml_ret, 1, _ret.y );

    CAMLreturn( ml_ret );
}


CAMLprim value
ml_cpBodySetPos( value body, value ml_p )
{
    cpVect p;
    p.x = Double_field(ml_p,0);
    p.y = Double_field(ml_p,1);

    cpBodySetPos( cpBody_val(body), p );
    return Val_unit;
}


CAMLprim value
ml_cpBodyGetVel( value body )
{
    CAMLparam0();
    CAMLlocal1( ml_ret );

    cpVect _ret = cpBodyGetVel( cpBody_val(body) );
    
    ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);

    Store_double_field( ml_ret, 0, _ret.x );
    Store_double_field( ml_ret, 1, _ret.y );

    CAMLreturn( ml_ret );
}


CAMLprim value
ml_cpBodySetVel( value body, value ml_v )
{
    cpVect v;
    v.x = Double_field(ml_v,0);
    v.y = Double_field(ml_v,1);

    cpBodySetVel( cpBody_val(body), v );
    return Val_unit;
}


CAMLprim value
ml_cpBodyGetForce( value body )
{
    CAMLparam0();
    CAMLlocal1( ml_ret );

    cpVect _ret = cpBodyGetForce( cpBody_val(body) );
    
    ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);

    Store_double_field( ml_ret, 0, _ret.x );
    Store_double_field( ml_ret, 1, _ret.y );

    CAMLreturn( ml_ret );
}


CAMLprim value
ml_cpBodySetForce( value body, value ml_f )
{
    cpVect f;
    f.x = Double_field(ml_f,0);
    f.y = Double_field(ml_f,1);

    cpBodySetForce( cpBody_val(body), f );
    return Val_unit;
}


CAMLprim value
ml_cpBodyGetAngle( value body )
{
    cpFloat _ret = cpBodyGetAngle( cpBody_val(body) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpBodySetAngle( value body, value a )
{
    cpBodySetAngle( cpBody_val(body), Double_val(a) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyGetAngVel( value body )
{
    cpFloat _ret = cpBodyGetAngVel( cpBody_val(body) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpBodySetAngVel( value body, value w )
{
    cpBodySetAngVel( cpBody_val(body), Double_val(w) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyGetTorque( value body )
{
    cpFloat _ret = cpBodyGetTorque( cpBody_val(body) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpBodySetTorque( value body, value t )
{
    cpBodySetTorque( cpBody_val(body), Double_val(t) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyGetRot( value body )
{
    CAMLparam0();
    CAMLlocal1( ml_ret );

    cpVect _ret = cpBodyGetRot( cpBody_val(body) );
    
    ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);

    Store_double_field( ml_ret, 0, _ret.x );
    Store_double_field( ml_ret, 1, _ret.y );

    CAMLreturn( ml_ret );
}


CAMLprim value
ml_cpBodyGetVelLimit( value body )
{
    cpFloat _ret = cpBodyGetVelLimit( cpBody_val(body) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpBodySetVelLimit( value body, value v_limit )
{
    cpBodySetVelLimit( cpBody_val(body), Double_val(v_limit) );
    return Val_unit;
}


CAMLprim value
ml_cpBodyGetAngVelLimit( value body )
{
    cpFloat _ret = cpBodyGetAngVelLimit( cpBody_val(body) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpBodySetAngVelLimit( value body, value w_limit )
{
    cpBodySetAngVelLimit( cpBody_val(body), Double_val(w_limit) );
    return Val_unit;
}


CAMLprim value
ml_cpShapeFree( value shape )
{
    cpShapeFree( cpShape_val(shape) );
    return Val_unit;
}


CAMLprim value
ml_cpResetShapeIdCounter( value unit )
{
    cpResetShapeIdCounter(  );
    return Val_unit;
}


CAMLprim value
ml_cpShapePointQuery( value shape, value ml_p )
{
    cpVect p;
    p.x = Double_field(ml_p,0);
    p.y = Double_field(ml_p,1);

    cpBool _ret = cpShapePointQuery( cpShape_val(shape), p );
    return Val_bool(_ret);
}


CAMLprim value
ml_cpShapeGetSensor( value shape )
{
    cpBool _ret = cpShapeGetSensor( cpShape_val(shape) );
    return Val_bool(_ret);
}


CAMLprim value
ml_cpShapeSetSensor( value shape, value value )
{
    cpShapeSetSensor( cpShape_val(shape), Bool_val(value) );
    return Val_unit;
}


CAMLprim value
ml_cpShapeGetElasticity( value shape )
{
    cpFloat _ret = cpShapeGetElasticity( cpShape_val(shape) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpShapeSetElasticity( value shape, value e )
{
    cpShapeSetElasticity( cpShape_val(shape), Double_val(e) );
    return Val_unit;
}


CAMLprim value
ml_cpShapeGetFriction( value shape )
{
    cpFloat _ret = cpShapeGetFriction( cpShape_val(shape) );
    return caml_copy_double(_ret);
}


CAMLprim value
ml_cpShapeSetFriction( value shape, value u )
{
    cpShapeSetFriction( cpShape_val(shape), Double_val(u) );
    return Val_unit;
}


CAMLprim value
ml_cpShapeGetSurfaceVelocity( value shape )
{
    CAMLparam0();
    CAMLlocal1( ml_ret );

    cpVect _ret = cpShapeGetSurfaceVelocity( cpShape_val(shape) );
    
    ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);

    Store_double_field( ml_ret, 0, _ret.x );
    Store_double_field( ml_ret, 1, _ret.y );

    CAMLreturn( ml_ret );
}


CAMLprim value
ml_cpShapeSetSurfaceVelocity( value shape, value ml_surface_v )
{
    cpVect surface_v;
    surface_v.x = Double_field(ml_surface_v,0);
    surface_v.y = Double_field(ml_surface_v,1);

    cpShapeSetSurfaceVelocity( cpShape_val(shape), surface_v );
    return Val_unit;
}


CAMLprim value
ml_cpShapeGetCollisionType( value shape )
{
    int _ret = cpShapeGetCollisionType( cpShape_val(shape) );
    return Val_long(_ret);
}


CAMLprim value
ml_cpShapeSetCollisionType( value shape, value ct )
{
    cpShapeSetCollisionType( cpShape_val(shape), Int_val(ct) );
    return Val_unit;
}


CAMLprim value
ml_cpShapeGetLayers( value shape )
{
    int _ret = cpShapeGetLayers( cpShape_val(shape) );
    return Val_long(_ret);
}


CAMLprim value
ml_cpShapeSetLayers( value shape, value layers )
{
    cpShapeSetLayers( cpShape_val(shape), Int_val(layers) );
    return Val_unit;
}


CAMLprim value
ml_cpPinJointNew( value a, value b, value ml_anchr1, value ml_anchr2 )
{
    cpVect anchr1;
    anchr1.x = Double_field(ml_anchr1,0);
    anchr1.y = Double_field(ml_anchr1,1);

    cpVect anchr2;
    anchr2.x = Double_field(ml_anchr2,0);
    anchr2.y = Double_field(ml_anchr2,1);

    cpConstraint *joint_constr = cpPinJointNew( cpBody_val(a), cpBody_val(b), anchr1, anchr2 );
    return (value) joint_constr;
}


CAMLprim value
ml_cpSlideJointNew( value a, value b, value ml_anchr1, value ml_anchr2, value min, value max )
{
    cpVect anchr1;
    anchr1.x = Double_field(ml_anchr1,0);
    anchr1.y = Double_field(ml_anchr1,1);

    cpVect anchr2;
    anchr2.x = Double_field(ml_anchr2,0);
    anchr2.y = Double_field(ml_anchr2,1);

    cpConstraint *joint_constr = cpSlideJointNew( cpBody_val(a), cpBody_val(b), anchr1, anchr2, Double_val(min), Double_val(max) );
    return (value) joint_constr;
}

CAMLprim value
ml_cpSlideJointNew_bc(value * argv, int argn)
{
    return ml_cpSlideJointNew(
      argv[0], argv[1], argv[2], argv[3], argv[4], argv[5] );
}


CAMLprim value
ml_cpPivotJointNew( value a, value b, value ml_pivot )
{
    cpVect pivot;
    pivot.x = Double_field(ml_pivot,0);
    pivot.y = Double_field(ml_pivot,1);

    cpConstraint *joint_constr = cpPivotJointNew( cpBody_val(a), cpBody_val(b), pivot );
    return (value) joint_constr;
}


CAMLprim value
ml_cpPivotJointNew2( value a, value b, value ml_anchr1, value ml_anchr2 )
{
    cpVect anchr1;
    anchr1.x = Double_field(ml_anchr1,0);
    anchr1.y = Double_field(ml_anchr1,1);

    cpVect anchr2;
    anchr2.x = Double_field(ml_anchr2,0);
    anchr2.y = Double_field(ml_anchr2,1);

    cpConstraint *joint_constr = cpPivotJointNew2( cpBody_val(a), cpBody_val(b), anchr1, anchr2 );
    return (value) joint_constr;
}


CAMLprim value
ml_cpGrooveJointNew( value a, value b, value ml_groove_a, value ml_groove_b, value ml_anchr2 )
{
    cpVect groove_a;
    groove_a.x = Double_field(ml_groove_a,0);
    groove_a.y = Double_field(ml_groove_a,1);

    cpVect groove_b;
    groove_b.x = Double_field(ml_groove_b,0);
    groove_b.y = Double_field(ml_groove_b,1);

    cpVect anchr2;
    anchr2.x = Double_field(ml_anchr2,0);
    anchr2.y = Double_field(ml_anchr2,1);

    cpConstraint *joint_constr = cpGrooveJointNew( cpBody_val(a), cpBody_val(b), groove_a, groove_b, anchr2 );
    return (value) joint_constr;
}


CAMLprim value
ml_cpConstraintFree( value constr )
{
    cpConstraintFree( cpConstraint_val(constr) );
    return Val_unit;
}


CAMLprim value
ml_cpDampedSpringNew( value a, value b, value ml_anchr1, value ml_anchr2, value rest_length, value stiffness, value damping )
{
    cpVect anchr1;
    anchr1.x = Double_field(ml_anchr1,0);
    anchr1.y = Double_field(ml_anchr1,1);

    cpVect anchr2;
    anchr2.x = Double_field(ml_anchr2,0);
    anchr2.y = Double_field(ml_anchr2,1);

    cpConstraint *joint_constr = cpDampedSpringNew( cpBody_val(a), cpBody_val(b), anchr1, anchr2, Double_val(rest_length), Double_val(stiffness), Double_val(damping) );
    return (value) joint_constr;
}

CAMLprim value
ml_cpDampedSpringNew_bc(value * argv, int argn)
{
    return ml_cpDampedSpringNew(
      argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6] );
}


// Structure member access

CAMLprim value
ml_cpCircleShapeSetRadius(value this, value val)
{
        ((cpCircleShape *)this)->r = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpCircleShapeSetCenter(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpCircleShape *)this)->c = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSegmentShapeSetA(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSegmentShape *)this)->a = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSegmentShapeSetB(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSegmentShape *)this)->b = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSegmentShapeSetNorm(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSegmentShape *)this)->n = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSegmentShapeSetThickness(value this, value val)
{
        ((cpSegmentShape *)this)->r = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpSegmentShapeSetTA(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSegmentShape *)this)->ta = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSegmentShapeSetTB(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSegmentShape *)this)->tb = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSegmentShapeSetTNorm(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSegmentShape *)this)->tn = _val;
        return Val_unit;
}

CAMLprim value
ml_cpConstraintSetMaxForce(value this, value val)
{
        ((cpConstraint *)this)->maxForce = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpConstraintSetErrorBias(value this, value val)
{
        ((cpConstraint *)this)->errorBias = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpConstraintSetMaxBias(value this, value val)
{
        ((cpConstraint *)this)->maxBias = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpPinJointSetAnchor1(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPinJoint *)this)->anchr1 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpPinJointSetAnchor2(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPinJoint *)this)->anchr2 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpPinJointSetDist(value this, value val)
{
        ((cpPinJoint *)this)->dist = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpPinJointSetR1(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPinJoint *)this)->r1 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpPinJointSetR2(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPinJoint *)this)->r2 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpPinJointSetVect(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPinJoint *)this)->n = _val;
        return Val_unit;
}

CAMLprim value
ml_cpPinJointSetNMass(value this, value val)
{
        ((cpPinJoint *)this)->nMass = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpPinJointSetJNAcc(value this, value val)
{
        ((cpPinJoint *)this)->jnAcc = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpPinJointSetBias(value this, value val)
{
        ((cpPinJoint *)this)->bias = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpSlideJointSetAnchor1(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSlideJoint *)this)->anchr1 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSlideJointSetAnchor2(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSlideJoint *)this)->anchr2 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSlideJointSetMin(value this, value val)
{
        ((cpSlideJoint *)this)->min = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpSlideJointSetMax(value this, value val)
{
        ((cpSlideJoint *)this)->max = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpSlideJointSetR1(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSlideJoint *)this)->r1 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSlideJointSetR2(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSlideJoint *)this)->r2 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSlideJointSetVect(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpSlideJoint *)this)->n = _val;
        return Val_unit;
}

CAMLprim value
ml_cpSlideJointSetNMass(value this, value val)
{
        ((cpSlideJoint *)this)->nMass = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpSlideJointSetJNAcc(value this, value val)
{
        ((cpSlideJoint *)this)->jnAcc = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpSlideJointSetBias(value this, value val)
{
        ((cpSlideJoint *)this)->bias = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpPivotJointSetAnchor1(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPivotJoint *)this)->anchr1 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpPivotJointSetAnchor2(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPivotJoint *)this)->anchr2 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpPivotJointSetR1(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPivotJoint *)this)->r1 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpPivotJointSetR2(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPivotJoint *)this)->r2 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpPivotJointSetJAcc(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPivotJoint *)this)->jAcc = _val;
        return Val_unit;
}

CAMLprim value
ml_cpPivotJointSetBias(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpPivotJoint *)this)->bias = _val;
        return Val_unit;
}

CAMLprim value
ml_cpGrooveJointSetGrvN(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpGrooveJoint *)this)->grv_n = _val;
        return Val_unit;
}

CAMLprim value
ml_cpGrooveJointSetGrvA(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpGrooveJoint *)this)->grv_a = _val;
        return Val_unit;
}

CAMLprim value
ml_cpGrooveJointSetGrvB(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpGrooveJoint *)this)->grv_b = _val;
        return Val_unit;
}

CAMLprim value
ml_cpGrooveJointSetAnchor2(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpGrooveJoint *)this)->anchr2 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpGrooveJointSetGrvTn(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpGrooveJoint *)this)->grv_tn = _val;
        return Val_unit;
}

CAMLprim value
ml_cpGrooveJointSetClamp(value this, value val)
{
        ((cpGrooveJoint *)this)->clamp = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpGrooveJointSetR1(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpGrooveJoint *)this)->r1 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpGrooveJointSetR2(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpGrooveJoint *)this)->r2 = _val;
        return Val_unit;
}

CAMLprim value
ml_cpGrooveJointSetJAcc(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpGrooveJoint *)this)->jAcc = _val;
        return Val_unit;
}

CAMLprim value
ml_cpGrooveJointSetBias(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpGrooveJoint *)this)->bias = _val;
        return Val_unit;
}

CAMLprim value
ml_cpArbiterSetE(value this, value val)
{
        ((cpArbiter *)this)->e = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpArbiterSetU(value this, value val)
{
        ((cpArbiter *)this)->u = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpArbiterSetSurface_vr(value this, value val)
{
        cpVect _val;
        _val.x = Double_field(val,0);
        _val.y = Double_field(val,1);

        ((cpArbiter *)this)->surface_vr = _val;
        return Val_unit;
}

CAMLprim value
ml_cpBBSetL(value this, value val)
{
        ((cpBB *)this)->l = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpBBSetB(value this, value val)
{
        ((cpBB *)this)->b = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpBBSetR(value this, value val)
{
        ((cpBB *)this)->r = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpBBSetT(value this, value val)
{
        ((cpBB *)this)->t = Double_val(val);
        return Val_unit;
}

CAMLprim value
ml_cpCircleShapeGetRadius(value this)
{
        return caml_copy_double( ((cpCircleShape *)this)->r );
}

CAMLprim value
ml_cpCircleShapeGetCenter(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpCircleShape *)this)->c ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSegmentShapeGetA(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSegmentShape *)this)->a ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSegmentShapeGetB(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSegmentShape *)this)->b ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSegmentShapeGetNorm(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSegmentShape *)this)->n ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSegmentShapeGetThickness(value this)
{
        return caml_copy_double( ((cpSegmentShape *)this)->r );
}

CAMLprim value
ml_cpSegmentShapeGetTA(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSegmentShape *)this)->ta ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSegmentShapeGetTB(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSegmentShape *)this)->tb ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSegmentShapeGetTNorm(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSegmentShape *)this)->tn ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPolyShapeGetNumVerts(value this)
{
        return Val_int( ((cpPolyShape *)this)->numVerts );
}

CAMLprim value
ml_cpPolyShapeGetVects(value this)
{
        CAMLparam0();
        CAMLlocal2( ml_ret, vert_i );

        int num = ((cpPolyShape *)this)->numVerts;
        cpVect *verts =  ((cpPolyShape *)this)->verts ;

        ml_ret = caml_alloc(num, 0);

        for (int i=0; i<num; i++) {

                vert_i = caml_alloc(2 * Double_wosize, Double_array_tag);

                Store_double_field( vert_i, 0, verts[i].x );
                Store_double_field( vert_i, 1, verts[i].y );

                Store_field( ml_ret, i, vert_i );
        }

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPolyShapeGetTVerts(value this)
{
        CAMLparam0();
        CAMLlocal2( ml_ret, vert_i );

        int num = ((cpPolyShape *)this)->numVerts;
        cpVect *verts =  ((cpPolyShape *)this)->tVerts ;

        ml_ret = caml_alloc(num, 0);

        for (int i=0; i<num; i++) {

                vert_i = caml_alloc(2 * Double_wosize, Double_array_tag);

                Store_double_field( vert_i, 0, verts[i].x );
                Store_double_field( vert_i, 1, verts[i].y );

                Store_field( ml_ret, i, vert_i );
        }

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpConstraintGetMaxForce(value this)
{
        return caml_copy_double( ((cpConstraint *)this)->maxForce );
}

CAMLprim value
ml_cpConstraintGetErrorBias(value this)
{
        return caml_copy_double( ((cpConstraint *)this)->errorBias );
}

CAMLprim value
ml_cpConstraintGetMaxBias(value this)
{
        return caml_copy_double( ((cpConstraint *)this)->maxBias );
}

CAMLprim value
ml_cpPinJointGetAnchor1(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPinJoint *)this)->anchr1 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPinJointGetAnchor2(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPinJoint *)this)->anchr2 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPinJointGetDist(value this)
{
        return caml_copy_double( ((cpPinJoint *)this)->dist );
}

CAMLprim value
ml_cpPinJointGetR1(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPinJoint *)this)->r1 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPinJointGetR2(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPinJoint *)this)->r2 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPinJointGetVect(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPinJoint *)this)->n ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPinJointGetNMass(value this)
{
        return caml_copy_double( ((cpPinJoint *)this)->nMass );
}

CAMLprim value
ml_cpPinJointGetJNAcc(value this)
{
        return caml_copy_double( ((cpPinJoint *)this)->jnAcc );
}

CAMLprim value
ml_cpPinJointGetBias(value this)
{
        return caml_copy_double( ((cpPinJoint *)this)->bias );
}

CAMLprim value
ml_cpSlideJointGetAnchor1(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSlideJoint *)this)->anchr1 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSlideJointGetAnchor2(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSlideJoint *)this)->anchr2 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSlideJointGetMin(value this)
{
        return caml_copy_double( ((cpSlideJoint *)this)->min );
}

CAMLprim value
ml_cpSlideJointGetMax(value this)
{
        return caml_copy_double( ((cpSlideJoint *)this)->max );
}

CAMLprim value
ml_cpSlideJointGetR1(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSlideJoint *)this)->r1 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSlideJointGetR2(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSlideJoint *)this)->r2 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSlideJointGetVect(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpSlideJoint *)this)->n ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpSlideJointGetNMass(value this)
{
        return caml_copy_double( ((cpSlideJoint *)this)->nMass );
}

CAMLprim value
ml_cpSlideJointGetJNAcc(value this)
{
        return caml_copy_double( ((cpSlideJoint *)this)->jnAcc );
}

CAMLprim value
ml_cpSlideJointGetBias(value this)
{
        return caml_copy_double( ((cpSlideJoint *)this)->bias );
}

CAMLprim value
ml_cpPivotJointGetAnchor1(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPivotJoint *)this)->anchr1 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPivotJointGetAnchor2(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPivotJoint *)this)->anchr2 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPivotJointGetR1(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPivotJoint *)this)->r1 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPivotJointGetR2(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPivotJoint *)this)->r2 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPivotJointGetJAcc(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPivotJoint *)this)->jAcc ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpPivotJointGetBias(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpPivotJoint *)this)->bias ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpGrooveJointGetGrvN(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpGrooveJoint *)this)->grv_n ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpGrooveJointGetGrvA(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpGrooveJoint *)this)->grv_a ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpGrooveJointGetGrvB(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpGrooveJoint *)this)->grv_b ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpGrooveJointGetAnchor2(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpGrooveJoint *)this)->anchr2 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpGrooveJointGetGrvTn(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpGrooveJoint *)this)->grv_tn ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpGrooveJointGetClamp(value this)
{
        return caml_copy_double( ((cpGrooveJoint *)this)->clamp );
}

CAMLprim value
ml_cpGrooveJointGetR1(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpGrooveJoint *)this)->r1 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpGrooveJointGetR2(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpGrooveJoint *)this)->r2 ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpGrooveJointGetJAcc(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpGrooveJoint *)this)->jAcc ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpGrooveJointGetBias(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpGrooveJoint *)this)->bias ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpArbiterGetE(value this)
{
        return caml_copy_double( ((cpArbiter *)this)->e );
}

CAMLprim value
ml_cpArbiterGetU(value this)
{
        return caml_copy_double( ((cpArbiter *)this)->u );
}

CAMLprim value
ml_cpArbiterGetSurface_vr(value this)
{
        CAMLparam0();
        CAMLlocal1( ml_ret );

        cpVect _ret =  ((cpArbiter *)this)->surface_vr ;
        
        ml_ret = caml_alloc(2 * Double_wosize, Double_array_tag);
        Store_double_field( ml_ret, 0, _ret.x );
        Store_double_field( ml_ret, 1, _ret.y );

        CAMLreturn( ml_ret );
}

CAMLprim value
ml_cpBBGetL(value this)
{
        return caml_copy_double( ((cpBB *)this)->l );
}

CAMLprim value
ml_cpBBGetB(value this)
{
        return caml_copy_double( ((cpBB *)this)->b );
}

CAMLprim value
ml_cpBBGetR(value this)
{
        return caml_copy_double( ((cpBB *)this)->r );
}

CAMLprim value
ml_cpBBGetT(value this)
{
        return caml_copy_double( ((cpBB *)this)->t );
}
