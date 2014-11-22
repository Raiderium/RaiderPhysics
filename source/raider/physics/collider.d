module raider.physics.collider;

import raider.math.vec;
import raider.physics.shape;
import raider.tools.reference;

/**
 * An interface for things interested in collisions.
 * 
 * A collider is associated with one or more shapes.
 * It defines callbacks for broad and narrow events.
 */
interface Collider
{public:

	/**
	 * Broadphase callback.
	 * 
	 * This is called when two shapes potentially intersect.
	 * 
	 * Returns:
	 * True to do narrowphase. Both colliders must agree, or 
	 * narrowphase is skipped. Null collider implies true.
	 */
	bool near(P!Shape A, P!Shape B);

	/**
	 * Narrowphase callback.
	 * 
	 * This is called for each contact discovered between
	 * two shapes. It is guaranteed that each call refers
	 * to the shapes given to the last near() call.
	 * 
	 * Returns:
	 * True to use the contact. Both colliders must agree,
	 * or the contact is discarded. Null collider implies 
	 * true.
	 */
	bool contact(vec3 pos, vec3 nor);
}