module raider.physics.space;

/**
 * Collision space.
 * 
 * Optimised for environments where all objects are moving.
 * Massively parallel insertion, deletion, update and test.
 * Does not exploit temporal coherency; special measures 
 * are taken to reduce the cost of complex static geometry.
 * 
 * Uses an algorithm based on Sort and Sweep that I like 
 * to call Sort and Sweep and Stumble (SASAS). It boils down
 * to a 1D SAS that can detect when objects cluster densely
 * and skip them (or 'stumble') to avoid inefficient tests.
 * It later sorts the clusters of untested objects on a 
 * perpendicular axis and sweeps them individually. If yet
 * more clusters are detected, a third phase may occur.
 * 
 * As an example, consider a cube of 10x10x10 smaller cubes.
 * 1D SAS on any axis will encounter 10 clusters needing
 * 5050 AABB tests each. In SASAS, the sweep stops if the
 * number of overlaps goes beyond a threshold. It finishes
 * the cluster and resumes sweeping when a certain number 
 * of overlaps are lost (though if there are still too many 
 * overlaps another cluster will begin immediately).
 * 
 * Clusters are appended to a buffer, pending the next phase.
 * Objects that overlap between clusters are duplicated.
 */
final class Space
{
	//void collide(bool function(P!Shape a, P!Shape b) near, )
}

/**
 * Floating point radix sort
 * 
 * Implementation based on http://stereopsis.com/radix.html
 */
private void radixSortFloats(float* input, float* sorted, uint elements)
{
	uint* sort = cast(uint*)sorted; 
	uint* array = cast(uint*)input;
	
	immutable uint kHist = 2048;
	uint b1Array[kHist * 3];
	
	uint* b0 = b1Array.ptr;
	uint* b1 = b0 + kHist;
	uint* b2 = b1 + kHist;
	
	for(int x = 0; x < elements; x++)
	{
		uint fi = array[x];
		
		//Flip float
		int m = fi >> 31;
		fi ^= -m | 0x80000000;
		
		b0[fi & 0x7FF]++;
		b1[fi >> 11 & 0x7FF]++;
		b2[fi >> 22]++;
	}
	
	uint s0, s1, s2, st;
	
	for(int x = 0; x < kHist; x++)
	{ st = b0[x] + s0; b0[x] = s0 - 1; s0 = st; }
	
	for(int x = 0; x < kHist; x++)
	{ st = b1[x] + s1; b1[x] = s1 - 1; s1 = st; }
	
	for(int x = 0; x < kHist; x++)
	{ st = b2[x] + s2; b2[x] = s2 - 1; s2 = st; }
	
	for(int x = 0; x < elements; x++)
	{
		uint fi = array[x];
		
		//Flip float
		int m = fi >> 31;
		fi ^= -m | 0x80000000;
		
		uint pos = fi & 0x7FF;
		sort[++b0[pos]] = fi;
	}
	
	for(int x = 0; x < elements; x++)
	{
		uint si = sort[x];
		uint pos = si >> 11 & 0x7FF;
		array[++b1[pos]] = si;
	}
	
	for(int x = 0; x < elements; x++)
	{
		uint ai = array[x];
		uint pos = ai >> 22;
		
		//Unflip float
		uint m = ((ai >> 31) - 1) | 0x80000000;	
		ai ^= m;
		sort[++b2[pos]] = ai;
	}
}