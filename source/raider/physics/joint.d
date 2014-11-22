module raider.physics.joint;

import raider.physics.bod;
import raider.tools.reference;

final class Joint
{public:
	this(R!Body body1, R!Body body2 = null)
	{
		assert(body1);
		assert(body1 !is body2); 
		if(body2) assert(body1.world == body2.world);
	}
}