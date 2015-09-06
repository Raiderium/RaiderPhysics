module raider.physics.bod;

import raider.math;
import raider.collision.shape;
import raider.physics.world;
import raider.physics.surface;
import raider.tools.array;
import raider.tools.reference;


/**
 * A mass.
 * 
 * Body + shapes = rigid body.
 * A body must not outlive the world it inhabits.
 */
final class Body(BU, SU)
{package:
	vec3 pos; //Position
	mat3 ori; //Orientation
	vec3 lvel, avel; //Linear and angular velocities
	vec3 facc, tacc; //Force and torque accumulators
	double imass; //Inverse mass (1/mass)

	R!Surface surface; //Default surface, if not overridden 

	BU data;

	Array!(R!(Shape!SU)) shapes; 
	P!(World!(BU, SU)) world;

public:
	this(P!(World!(BU, SU)) world)
	{
		this.world = world;
	}

	~this()
	{

	}

	///Get the total mass of the body.
	@property double mass()
	{
		return 1.0 / imass;
	}

	///Set the total mass of the body.
	@property void mass(double value)
	{
		imass = 1.0 / value;
	}

	///Set the mass shape to a box of the given dimensions.
	@property void massShape(vec3 value)
	{
	
	}

	@property bool kinematic() { return true; }
	@property void kinematic(bool value) { }
	@property vec3 position() { return vec3(); }
	@property void position(vec3 value) { }
	@property mat3 orientation() { mat3 r; return r; }
	@property void orientation(mat3 value) { }
	@property mat4 transform() { return mat4(orientation, position); }
	@property vec3 velocity() { return vec3(); }
	@property void velocity(vec3 value) { }
	@property vec3 localVelocity() { return orientation * velocity; }
	@property void localVelocity(vec3 value) { velocity = value * orientation; }
	@property vec3 angularVelocity() { return vec3(); }
	@property void angularVelocity(vec3 value) { }
	@property vec3 localAngularVelocity() { return orientation * angularVelocity; }
	@property void localAngularVelocity(vec3 value) { angularVelocity = value * orientation; }

	vec3 getVelocityAt(vec3 point, bool localPoint = true)
	{
		return velocity + angularVelocity.cross(localPoint ? point * orientation : point - position);
	}

	void applyForce(vec3 f, vec3 pos = vec3(0,0,0), bool localForce = false, bool localPos = true)
	{
		if(pos == vec3(0,0,0)) {
			if (localForce) {}  //dBodyAddRelForce(dbody, f[0], f[1], f[2]);
			else {}  //dBodyAddForce(dbody, f[0], f[1], f[2]);
		} else {
			if (localForce) {
				if (localPos) {} //dBodyAddRelForceAtRelPos(dbody, f[0], f[1], f[2], pos[0], pos[1], pos[2]);
				else {} //dBodyAddRelForceAtPos(dbody, f[0], f[1], f[2], pos[0], pos[1], pos[2]);
			} else {
				if (localPos) {} //dBodyAddForceAtRelPos(dbody, f[0], f[1], f[2], pos[0], pos[1], pos[2]);
				else {} //dBodyAddForceAtPos(dbody, f[0], f[1], f[2], pos[0], pos[1], pos[2]);
			}
		}
	}

	void applyTorque(vec3 t, bool localTorque)
	{
		if(localTorque) {} //dBodyAddRelTorque(dbody, t[0], t[1], t[2]);
		else {} //dBodyAddTorque(dbody, t[0], t[1], t[2]);
	}
}