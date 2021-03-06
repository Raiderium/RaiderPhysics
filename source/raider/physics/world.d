module raider.physics.world;

import core.sync.mutex;
import raider.math;
import raider.physics.bod;
import raider.collision.collider;
import raider.collision.shape;
import raider.tools.reference;

/**
 * Physical world encapsulating both collision and dynamics.
 */

class World(BU, SU)
{package:
	R!(Body!(BU, SU)) staticBody;
	int _pairs;
	R!Mutex mutex;
	vec3 _gravity = vec3(0,0,-9.81);
public:

	@property int pairs() { return _pairs; }
	immutable static uint maxContactsPerPair = 8;

	this()
	{
		mutex = New!Mutex();
	}

	~this()
	{ }

	void step(double dt)
	{ }

	@property void gravity(vec3 value)
	{ _gravity = value; }

	@property vec3 gravity()
	{ return _gravity; }
}



