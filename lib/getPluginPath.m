%% getPluginPath
% Return the path to the folder in which the REGGUI plugin is stored. If a name is provided as input, then  the path to the specified plugin is returned. The plugin name must match (respecting the case) the name of the folder in which the plugin code is stored. If no input is provided, the path to the root folder where the plugins are stored is returned. If an error occured, the function returns an empty string.
%
%% Syntax
% |pluginPath = getPluginPath(pluginName)|
%
%% Description
% |pluginPath = getPluginPath| return the path to the root folder where plugins are stored
%
% |pluginPath = getPluginPath(pluginName)| Return the path to the folder where the specified plugin is stored
%

%% Input arguments
% |pluginName| - _STRING_ - [OPTIONAL] Name of the plugin. If absent, the path to the root plugin folder will be returned.
%
%% Output arguments
%
% |pluginPath| - _STRING_ -  Full path to the folder of the specified plugin or path to the root folde of the plugins
%
%
%% Contributors
% Authors : Rudi Labarbe (open.reggui@gmail.com)

% Note: the function getPluginPath.m must be saved in the root folder where the plugins are stored. In this way, if this folder is moved to a new location, this function will continue to work properly.

function pluginPath = getPluginPath(pluginName)

[pluginPath ,name]= fileparts(fileparts(mfilename('fullpath')));
pluginPath = fullfile(pluginPath,name);

if nargin < 1
	%No input parameter. Return the path to the root folder where plugins are stored
	return
end

if exist(fullfile(pluginPath,pluginName))==7
	% The plugin name exist and is a folder
	pluginPath = fullfile(pluginPath , pluginName);
	return
else
	% The plugin name does not exist. REturn empty string
	pluginPath = []
	return
end

return
