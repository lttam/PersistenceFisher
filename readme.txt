NOTES:

----------------------------------
* SETUP:
----------------------------------
+ run setup for setpath for figtree (precompiled for Mac and Linux)


----------------------------------
* DEMO:
----------------------------------
+ test_dFIM: randomly generate two persistence diagrams, and compute the Fisher information metric
between them, with or without Fast Gauss Transform.


----------------------------------
* FUNCTIONS in LIB:
----------------------------------
+ compute_dFIM_distance: compute Fisher information metric between two persistence diagrams
(without Fast Gauss Transform --- Quadratic complexity)
<Algorithm 1 in the NIPS'18 paper)
+ compute_dFIM_distance_FGT: compute Fisher information metric between two persistence diagrams,
approximated by Fast Gauss Transform --- Linear complexity
<Algorithm 1 in the NIPS'18 paper>
+ Third party toolbox (figtree-0.9.3): Fast Gauss Transform library
(Link: http://www.umiacs.umd.edu/~morariu/figtree/   
or  http://sourceforge.net/projects/figtree)


----------------------------------
RELEVANT PAPER:
----------------------------------
Tam Le, Makoto Yamada, Persistence Fisher Kernel: A Riemannian Manifold Kernel
for Persistence Diagrams, Neural Information Processing Systems (NIPS), Canada, 2018.

ArXiv link: https://arxiv.org/abs/1802.03569

----------------------------------
* CONTACT
----------------------------------
% Version 0.1 (October 19th, 2018)
@ Tam Le - RIKEN AIP
Email: tam.le@riken.jp
Homepage: https://sites.google.com/site/lttamvn/


Please contact me if you observe any bugs in the execution of the algorithms.
Many thanks !!!


