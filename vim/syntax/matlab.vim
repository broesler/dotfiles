"===============================================================================
"    File: ~/.vim/syntax/matlab.vim
"  Author: Bernie Roesler
" Credits: Michael Kruszec <mkruszec@interia.pl>
"          Preben "Peppe" Guldberg <c928400@student.dtu.dk>
"          Original author: Mario Eusebio
"
" Last Updated: 02/23/2016, 19:04
"===============================================================================

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Do not match keywords preceded by a dot '.', these are structure field names
" syn match DotKeyStart '\.' nextgroup=DotKeys
" To highlight structure field names, use i.e.
"+ syn keyword DotKeys contained Keyword1 Keyword2

syn keyword matlabConditional           if else elseif end otherwise true false
syn keyword matlabExceptions            try catch throw rethrow
syn keyword matlabFunction              function warning error eval 
syn keyword matlabImplicit              clear clc clf clr
syn keyword matlabLabel                 case switch
syn keyword matlabOO                    classdef properties events methods
syn keyword matlabRepeat                for while parfor 
syn keyword matlabScope                 global persistent
syn keyword matlabStatement             return break continue

syn match matlabArithmeticOperator      display "[-+]"
syn match matlabArithmeticOperator      display "\.\=[*/\\^]"
syn match matlabRelationalOperator      display "[=~]="
syn match matlabRelationalOperator      display "[<>]=\="
syn match matlabLogicalOperator         display "[&|~]"

" Highlight callouts in comments
syn match matlabTodo contained "\(TODO\|NOTE\|FIXME\)"
syn match matlabTab display "\t"

syn match matlabComment display "%.*$" contains=matlabTodo,matlabTab,matlabCommentTitle
syn match matlabComment display "\.\.\..*$" contains=matlabTodo,matlabCommentTitle
syn match matlabCommentTitle '%\s*\%([sS]:\|\h\w*#\)\=\u\w*\(\s\+\u\w*\)*:'hs=s+1 contained contains=matlabTodo

" NOTE: To match block comments '%{' and '%}' must start lines by themselves,
"+  with no other non-spaces before or after them
syn region matlabMultilineComment start=/^\s*%{\s*$/ end=/^\s*%}\s*$/ contains=matlabTodo

syn match matlabContinueLine  display "\.\{3}"

syn region matlabString display start=+'+ end=+'+ oneline skip=+''+     contains=matlabCtrlSeq,matlabFormat

" Standard numbers
syn match matlabNumber   "\<\d\+[ij]\=\>"
syn match matlabFloat    "\<\d\+\(\.\d*\)\=\([edED][-+]\=\d\+\)\=[ij]\=\>"
syn match matlabFloat    "\.\d\+\([edED][-+]\=\d\+\)\=[ij]\=\>"

" Transpose character and delimiters: Either use just [...] or (...) as well
syn match matlabDelimiter          "[][]"
syn match matlabTransposeOperator  display "\([])a-zA-Z0-9.]\)\@<='"
syn match matlabSemicolon          display ";"

" FIXME Field names are preceded by a dot
syn match matlabFieldName       "\.\I\i*" transparent

" Match 
syn match matlabError   "-\=\<\d\+\.\d\+\.[^*/\\^]"
syn match matlabError   "-\=\<\d\+\.\d\+[eEdD][-+]\=\d\+\.\([^*/\\^]\)"

" Control sequences
syn match   matlabCtrlSeq	"\\\d\d\d\|\\[abcfnrtv0]"			contained
syn match	matlabFormat	display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained

"-------------------------------------------------------------------------------
"       List of ALL Matlab functions -- comment out, unnecessary    {{{
"-------------------------------------------------------------------------------
" syn keyword matlabImplicit              abs acos acosh acot acoth acsc acsch actxcontrol actxserver addframe addpath addproperty  airy alim all allchild alpha alphamap angle ans any area asec asech asin asinh assignin atan atan2 atanh audiodevinfo audioplayer audiorecorder auread auwrite avifile aviinfo aviread axes Axes Properties axis
" syn keyword matlabImplicit              balance bar barh bar3 bar3h base2dec beep besselh besseli besselj besselk bessely beta betainc betaln bicg bicgstab bin2dec bitand bitcmp bitget bitmax bitor bitset bitshift bitxor blanks blkdiag box break brighten builtin bvp4c bvpget bvpinit bvpset bvpval
" syn keyword matlabImplicit              calendar camdolly camlight camlookat camorbit campan campos camproj camroll camtarget camup camva camzoom capture cart2pol cart2sph cat caxis cd cdf2rdf cdfepoch cdfinfo cdfread cdfwrite ceil cell cell2mat cell2struct celldisp cellfun cellplot cellstr cgs char checkin checkout chol cholinc cholupdate circshift cla clabel class clc clear clf clipboard clock close closereq cmopts colamd colmmd colorbar colordef colormap colormapeditor ColorSpec colperm comet comet3 compan compass complex computer cond condeig condest coneplot conj continue contour contour3 contourc contourf contourslice contrast conv conv2 convhull convhulln convn copyfile copyobj corrcoef cos cosh cot coth cov cplxpair cputime cross csc csch csvread csvwrite cumprod cumsum cumtrapz curl customverctrl cylinder
" syn keyword matlabImplicit              daspect date datenum datestr datetick datevec dbclear dbcont dbdown dblquad dbmex dbquit dbstack dbstatus dbstep dbstop dbtype dbup dde23 ddeadv ddeexec ddeget ddeinit ddepoke ddereq ddeset ddeterm ddeunadv deal deblank dec2base dec2bin dec2hex deconv del2 delaunay delaunay3 delaunayn delete delete deleteproperty demo depdir depfun det detrend deval diag dialog diary diff dir disp display divergence dlmread dlmwrite dmperm doc docopt docroot dos dot double dragrect drawnow dsearch dsearchn
" syn keyword matlabImplicit              echo edit eig eigs ellipj ellipke ellipsoid eomday eps erf erfc erfcx erfinv erfcinv error errorbar errordlg etime etree etreeplot eval evalc evalin eventlisteners events exist exit exp expint expm eye ezcontour ezcontourf ezmesh ezmeshc ezplot ezplot3 ezpolar ezsurf ezsurfc
" syn keyword matlabImplicit              factor factorial false fclose fclose (serial) feather feof ferror feval fft fft2 fftn fftshift fgetl fgetl fgets fieldnames figflag figure Figure Properties file formats fileattrib filebrowser fileparts filesep fill fill3 filter filter2 find findall findfigs findobj findstr finish fitsinfo fitsread fix flipdim fliplr flipud floor flops flow fmin fminbnd fmins fminsearch fopen fopen format fplot fprintf fprintf  frame2im frameedit fread fread freeserial freqspace frewind fscanf fscanf fseek ftell full fullfile func2str function_handle functions funm fwrite fwrite fzero
" syn keyword matlabImplicit              gallery gamma gammainc gammaln gca gcbf gcbo gcd gcf gco genpath get get getappdata getenv getfield getframe ginput gmres gplot gradient graymon grid griddata griddata3 griddatan gsvd gtext guidata guide guihandles
" syn keyword matlabImplicit              hadamard hankel hdf hdfinfo hdfread hdftool help helpbrowser helpdesk helpdlg helpwin hess hex2dec hex2num hgload hgsave hidden hilb hist histc hold home horzcat hsv2rgb
" syn keyword matlabImplicit              ifft ifft2 ifftn ifftshift im2frame im2java imag image Image Properties imagesc imfinfo imformats import importdata imread imwrite ind2rgb ind2sub Inf inferiorto info inline inmem inpolygon input inputdlg inputname inspect instrcallback instrfind int2str int8 int16 int32 int64 interp1 interp2 interp3 interpft interpn interpstreamspeed intersect inv invhilb invoke ipermute is* isa isappdata iscell iscellstr ischar isempty isequal isequalwithequalnans isevent  isfield isfinite isglobal ishandle ishold isinf isjava iskeyword isletter islogical ismember ismethod  isnan isnumeric isobject isocaps isocolors isonormals isosurface ispc isprime isprop isreal isruntime issorted isspace issparse isstr isstruct isstudent isunix isvalid isvalid isvarname
" syn keyword matlabImplicit              javaArray javachk javaMethod javaObject
" syn keyword matlabImplicit              keyboard kron
" syn keyword matlabImplicit              lasterr lasterror lastwarn lcm legend legendre length length license light Light Properties lightangle lighting lin2mu line Line Properties LineSpec linspace listdlg load loadobj log log10 log2 logical loglog logm logspace lookfor lower ls lscov lsqnonneg lsqr lu luinc
" syn keyword matlabImplicit              magic mat2cell mat2str material matlab matlabrc matlabroot max mean median memory menu mesh meshc meshz meshgrid methods methodsview mex mexext mfilename min minres mislocked mkdir mkpp mlock mod more move movefile movegui movie movie2avi moviein msgbox mu2lin multibandread multibandwrite munlock
" syn keyword matlabImplicit              namelengthmax NaN nargchk nargin, nargout nargoutchk nchoosek ndgrid ndims newplot nextpow2 nnls nnz noanimate nonzeros norm normest notebook now null num2cell num2str numel nzmax
" syn keyword matlabImplicit              ode45 ode23 ode113 ode15s ode23s ode23t ode23tb odefile odeget odeset ones open openfig opengl openvar optimget optimset orderfields orient orth otherwise
" syn keyword matlabImplicit              pack pagedlg pagesetupdlg pareto partialpath pascal patch Patch Properties path path2rc pathtool pause pbaspect pcg pchip pcode pcolor pdepe pdeval peaks perl perms permute pi pie pie3 pinv planerot plot plot3 plotedit plotmatrix plotyy pol2cart polar poly polyarea polyder polyeig polyfit polyint polyval polyvalm pow2 ppval prefdir primes print printopt printdlg printpreview prod profile profreport propedit psi pwd
" syn keyword matlabImplicit              qmr qr qrdelete qrinsert qrupdate quad quad8 quadl questdlg quit quiver quiver3 qz
" syn keyword matlabImplicit              rand randn randperm rank rat rats rbbox rcond readasync real reallog realmax realmin realpow realsqrt record rectangle rectangle properties rectint reducepatch reducevolume refresh regexp regexpi regexprep registerevent rehash release rem repmat reset reshape residue rethrow rgb2hsv rgbplot ribbon rmappdata rmdir rmfield rmpath root object Root Properties roots rose rosser rot90 rotate rotate3d round rref rsf2csf run runtime
" syn keyword matlabImplicit              save save saveas saveobj scatter scatter3 schur script sec sech selectmoveresize semilogx semilogy send sendmail serial serialbreak set set setappdata setdiff setfield setstr setxor shading shiftdim shrinkfaces sign sin single sinh size size slice smooth3 sort sortrows sound soundsc spalloc sparse spaugment spconvert spdiags speye spfun sph2cart sphere spinmap spline spones spparms sprand sprandn sprandsym sprank sprintf spy sqrt sqrtm squeeze sscanf stairs start startat startup std stem stem3 stop stopasync str2double str2func str2mat str2num strcat strcmp strcmpi stream2 stream3 streamline streamparticles streamribbon streamslice streamtube strfind strings strjust strmatch strncmp strncmpi strread strrep strtok struct struct2cell strvcat sub2ind subplot subsasgn subsindex subspace subsref substruct subvolume sum superiorto support surf surfc surf2patch surface Surface Properties surfl surfnorm svd svds symamd symbfact symmlq symmmd symrcm symvar system
" syn keyword matlabImplicit              tan tanh tempdir tempname terminal tetramesh texlabel text Text Properties textread textwrap tic toc timer timerfind title toeplitz trace trapz treelayout treeplot tril trimesh triplequad triplot trisurf triu true tsearch tsearchn type
" syn keyword matlabImplicit              uicontextmenu uicontextmenu Properties uicontrol Uicontrol Properties uigetdir uigetfile uiimport uimenu Uimenu Properties uint8 uint16 uint32 uint64 uiputfile uiresume uiwait uisetcolor uisetfont uistack undocheckout union unique unix unmkpp unregisterallevents unregisterevent unwrap unzip upper urlread urlwrite usejava
" syn keyword matlabImplicit              vander var varargin varargout vectorize ver verctrl version vertcat view viewmtx volumebounds voronoi voronoin
" syn keyword matlabImplicit              wait waitbar waitfor waitforbuttonpress warndlg waterfall wavplay wavread wavrecord wavwrite web weekday what whatsnew which while whitebg who whos wilkinson winopen wk1read wk1write workspace
" syn keyword matlabImplicit              xlabel ylabel zlabel xlim ylim zlim xlsfinfo xlsread xmlread xmlwrite xor xslt zeros zip zoom
" " Control System Toolbox functions
" syn keyword matlabImplicit              acker allmargin append augstate balreal bandwidth bode bodemag c2d canon care chgunits conj connect covar ctrb ctrbf d2c d2d damp dare dcgain delay2z dlqr dlyap drss dsort dss dssdata esort estim evalfr feedback filt frd frdata freqresp gensig get gram hasdelay impulse initial interp inv iopzmap isct isdt isempty isproper issiso kalman kalmd lft lqgreg lqr lqrd lqry lsim ltimodels ltiprops ltiview lyap margin minreal modred ndims ngrid nichols norm nyquist obsv obsvf ord2 pade parallel place pole pzmap reg reshape rlocus rss series set sgrid sigma sisotool size sminreal ss ss2ss ssbal ssdata stack step tf tfdata totaldelay zero zgrid zpk zpkdata
" }}}

"------------------------------------------------------------------------------
"       Link highlights to colors  {{{
"------------------------------------------------------------------------------
if !exists("did_matlab_syntax_inits")
  hi def link matlabArithmeticOperator    matlabOperator
  hi def link matlabComment               Comment
  hi def link matlabCommentTitle          PreProc
  hi def link matlabConditional           Conditional
  hi def link matlabCtrlSeq               Special
  hi def link matlabDelimiter             Identifier
  hi def link matlabError                 Error
  hi def link matlabExceptions            Conditional
  hi def link matlabFloat                 Float
  hi def link matlabFormat                SpecialChar
  hi def link matlabFunction              Function
  hi def link matlabImplicit              Statement
  hi def link matlabLabel                 Label
  hi def link matlabContinueLine          matlabStatement
  hi def link matlabLogicalOperator       matlabOperator
  hi def link matlabMultilineComment      Comment
  hi def link matlabNumber                Number
  hi def link matlabOO                    Statement
  hi def link matlabOperator              Operator
  hi def link matlabRelationalOperator    matlabOperator
  hi def link matlabRepeat                matlabOperator
  hi def link matlabScope                 Type
  hi def link matlabSemicolon             Statement
  " hi def link matlabStatement             Statement
  hi def link matlabStatement             Function
  hi def link matlabString                String
  hi def link matlabTodo                  Todo
  hi def link matlabTransposeOperator     matlabOperator
  hi def link matlabTransposeOther        Identifier

  " Use magenta like in actual MATLAB instead of standard blue
  " hi matlabString                         ctermfg=125

  " optional highlighting
  hi def link matlabIdentifier            Identifier
  hi def link matlabTab                   Error

endif
"}}}

" Make sure block comments synchronize properly, but syntax isn't super slow
" if we have a really long file
syn sync minlines=200

" Set syntax file for current buffer
let b:current_syntax = "matlab"

"===============================================================================
"===============================================================================
