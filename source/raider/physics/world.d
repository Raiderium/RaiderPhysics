module raider.physics.world;

import core.sync.mutex;
import raider.math.all;
import raider.physics.bod;
import raider.physics.collider;
import raider.physics.shape;
import raider.tools.reference;

/**
 * Physical world encapsulating both collision and dynamics.
 */

class World
{package:
	R!Body staticBody;
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



