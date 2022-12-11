%%%%%%%%%%%%%%%%%%%%%%%%%% EXPERIMENT PARAMETERS (edit as necessary)
clear all
close all
sca
clc
addpath(genpath('~/Desktop/Kendrick_PRF_LowVision/knkutils'));

% display
ptres = [1920 1080 120 24];  % display resolution. [] means to use current display resolution. 
%TODO: The stimulus is hard coded for 120Hz. make it adaptive to diffrent refresh rates

ScreenRes=43.64; %Pixel/deg

% fixation dot
fixationinfo = {uint8([255 0 0; 0 0 0; 255 255 255]) 0.5};  % dot colors and alpha value
FixSize_Deg=sqrt(1^2/2); % fixation size in degree
fixationsize =floor(ScreenRes*FixSize_Deg); % 10;          % fixation size in pixels
meanchange = 3;            % dot changes occur with this average interval (in seconds)
changeplusminus = 2;       % plus or minus this amount (in seconds)

% trigger
datapixxFlag = 0;
triggerkey = 't';          % stimulus starts when this key is detected 

tfun = @() fprintf('STIMULUS STARTED.\n');  % function to call once trigger is detected

% tweaking
offset = [0 0];            % [X Y] where X and Y are the horizontal and vertical
                           % offsets to apply.  for example, [5 -10] means shift 
                           % 5 pixels to right, shift 10 pixels up.
movieflip = [0 0];         % [A B] where A==1 means to flip vertical dimension
                           % and B==1 means to flip horizontal dimension

% directories
stimulusdir = '~/Desktop/Kendrick_PRF_LowVision/dot_mat_files_prf';     % path to directory that contains the stimulus .mat files
% stimulusdir = '~/Dropbox (RVL)/Kendrick_PRF_LowVision/dot_mat_files_prf';     % path to directory that contains the stimulus .mat files

%Screen('Preference', 'SkipSyncTests', 1)
%%%%%%%%%%%%%%%%%%%%%%%%%% DO NOT EDIT BELOW

% set rand state
rand('state',sum(100*clock));
randn('state',sum(100*clock));

% ask the user what to run
if ~exist('subjnum','var') 
  subjnum = input('What is the subj id? ')
end
expnum = input('What experiment (89=CCW, 90=CW, 91=expand, 92=contract, 93=multibar, 94=wedgeringmash, 134=low vision multibar, 135=low vision wedgeringmash )? ')
runnum = input('What run number (for filename)? ')

% prepare inputs
trialparams = [];
ptonparams = {ptres,[],0};
dres = -0.87;% -1.4; % []; % Scaling factor
frameduration = 8; %monitor refresh rate/desired frame rate.  
% do not forget to change to an approproate frame down-sampling factor in showmulticlass_nyuad.m
% showm
grayval = uint8(127);
iscolor = 1;
soafun = @() round(meanchange*(60/frameduration) + changeplusminus*(2*(rand-.5))*(60/frameduration));

% load specialoverlay
a1 = load(fullfile(stimulusdir,'fixationgrid.mat'));

% some prep
if ~exist('images','var')
  images = [];
  maskimages = [];
end
filename = sprintf('%s_subj%d_run%02d_exp%02d.mat',gettimestring,subjnum,runnum,expnum);

% run experiment
[images,maskimages] = ...
    showmulticlass_nyuad(filename,offset,movieflip,frameduration,fixationinfo,fixationsize,tfun, ...
    ptonparams,soafun,0,images,expnum,[],grayval,iscolor,[],[],[],dres,triggerkey, ...
    [],trialparams,[],maskimages,a1.specialoverlay,stimulusdir);

%%%%%%%%%%%%%%%%%%%%%%%%%%

% KK notes:
% - remove performance check at end
% - remove resampling and viewingdistance stuff
% - remove hresgrid and vresgrid stuff
% - hardcode grid and pregenerate
% - trialparams became an internal constant
