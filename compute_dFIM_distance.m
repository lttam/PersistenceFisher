function dd = compute_dFIM_distance(p1, p2, delta)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 0.1 (October 19th, 2018)
% Compute Fisher Information metric between two persistence diagrams
% (without Fast Gauss Transform)
% (*Quadratic* complexity to the number of points in persistence diagrams)
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

% OUTPUT
% dd: d_FIM in Algorithm 1

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

% For pdu
tmpPDU = zeros(size(pp,1), size(pu,1));
for ii = 1:size(pu, 1)
    tmpPDU(:, ii) = mvnpdf(pp, pu(ii, :), delta*eye(size(pu,2)));
end
tmpPDU = tmpPDU .* repmat(wu', size(pp, 1), 1);
pdu = sum(tmpPDU, 2);

% For pdv
tmpPDV = zeros(size(pp,1), size(pv, 1));
for ii=1:size(pv, 1)
    tmpPDV(:, ii) = mvnpdf(pp, pv(ii, :), delta*eye(size(pv,2)));
end
tmpPDV = tmpPDV .* repmat(wv', size(pp,1), 1);
pdv = sum(tmpPDV, 2);

% Normalization
pdu = pdu / sum(pdu);
pdv = pdv / sum(pdv);

% Hellinger mapping
su = sqrt(pdu);
sv = sqrt(pdv);

% distance
dd = acos(sum(su.*sv));

end
