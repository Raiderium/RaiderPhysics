module raider.physics.arbiter;

/*
 * Must store arbiters as static array on shapes.
 * When a pair collides, search both shapes for matching arbiter.
 * If not found, add new arbiter to shape with least arbiters.
 * Give deepest contact to arbiter. It updates the contact manifold whatsit.
 * Iterate all shapes and arbiters.
 * If an arbiter has not been touched, remove it.
 * Otherwise, apply contact forces.
 */

struct Arbiter(BU, SU)
{

}