function dd = compute_dFIM_distance_FGT(p1, p2, delta, epsilonFGT)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 0.1 (October 19th, 2018)
% Compute Fisher Information metric between two persistence diagrams
% approximated by Fast Gauss Transform with an bounded error
% (*Linear* complexity to the number of points in persistence diagrams)
% <Algorithm 1 in the NIPS'18 paper>
%
% Author: Tam Le @RIKEN AIP
% Email: tam.le@riken.jp
% Homepage: https://sites.google.com/site/lttamvn/
%
% Relevent paper: 
% Tam Le, Makoto Yamada, Persistence Fisher Kernel: A Riemannian Manifold 
% Kernel for Persistence Diagrams, Neural Information Processing Systems 
% (NIPS), Canada, 2018.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INPUT
% p1: (n1x2) persistence diagram 1
% p2: (n2x2) persistence diagram 2
% delta: a smoothing parameter of Gaussian function.
% epsilonFGT: tolerance for Fast Gauss Transform (optional)

% OUTPUT
% dd: d_FIM in Algorithm 1

if nargin < 4
    epsilonFGT = 1e-6;
end

% projection of p1 on delta (y=x)
p1d = p1;
p1d(:, 1) = sum(p1, 2)/2;
p1d(:, 2) = sum(p1, 2)/2;

% projection of p2 on delta (y=x)
p2d = p2;
p2d(:, 1) = sum(p2, 2)/2;
p2d(:, 2) = sum(p2, 2)/2;

% same measure mass
pu = [p1 ; p2d];
pv = [p2 ; p1d];

% normalized (uniformly)
% (For extension: may consider for different weights i.e. pers)
ww = ones(size(pu, 1), 1);
ww = ww / sum(ww);

% weight for each smooth distribution in pu, pv respectively (uniformly)
wu = ww;
wv = ww;

% all points (Theta set in Algorithm 1)
pp = [pu ; pv];

% Parameters for Fast Gauss Transform using for the case of d_FIM
evalMethod = 4; 
ifgtParamMethod = 1; 
ifgtTruncMethod = 2; 
verbose=0;

% Computing via Fast Gauss Transform
pdu = figtree(pu', delta, wu', pp', epsilonFGT, evalMethod, ifgtParamMethod, ifgtTruncMethod, verbose);
pdv = figtree(pv', delta, wv', pp', epsilonFGT, evalMethod, ifgtParamMethod, ifgtTruncMethod, verbose);

% Normalization
pdu = pdu / sum(pdu);
pdv = pdv / sum(pdv);

% Hellinger mapping
su = sqrt(pdu);
sv = sqrt(pdv);

% distance
dd = acos(sum(su.*sv));

end
