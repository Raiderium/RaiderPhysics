module raider.physics.joint;

import raider.physics.bod;
import raider.tools.reference;

final class Joint(BU, SU)
{public:
	this(R!(Body!(BU, SU)) body1, R!(Body!(BU, SU)) body2 = null)
	{
		assert(body1);
		assert(body1 !is body2); 
		if(body2) assert(body1.world == body2.world);
	}
}