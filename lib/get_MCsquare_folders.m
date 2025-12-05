%% get_MCsquare_folders
% Return the path to the folders containing the information to use with MCsquare.
% If no |Scanner| , |BDL| is provided, then the default MCsquare folders are returned.
%
% If |Scanner| is provided:
%   * It can be a sub-folder of the present folder.
%   * It can be a full path to a folder
%   * It can be a sub-folder at the default location (REGGUI/MCsquare/lib/Scanners)
%
% If |BDL| is provided:
%   * It can be a file in the |ScannersPath| folder
%   * It can be a full path to a folder
%   * It can be a file in the default folder (REGGUI/MCsquare/lib/BDL)
%
%
%% Syntax
% |[pluginPath , MCsqExecPath , BDLPath , MaterialsPath , ScannersPath] = get_MCsquare_folders()|
%
% |[pluginPath , MCsqExecPath , BDLPath , MaterialsPath , ScannersPath] = get_MCsquare_folders(Scanner , BDL)|
%
%
%% Description
% |[pluginPath , MCsqExecPath , BDLPath , MaterialsPath , ScannersPath] = get_MCsquare_folders()| GEt the default MCsquare folders
%
% |[pluginPath , MCsqExecPath , BDLPath , MaterialsPath , ScannersPath] = get_MCsquare_folders(Scanner , BDL)| Get the folder for the provided BDL and scanner
%
%
%% Input arguments
%
% |Scanner| - _STRING_ - [OPTIONAL. If no provided, the function retuerns the default parameters] Name of the CT scanner used to image the patient. If this is a file name, the default path to the file is added. If it is a full path, then the full path is returned.
%
% |BDL| - _STRING_ - [OPTIONAL. If no provided, the function retuerns the default parameters]  Name of the file with the description of the beam data library (BDL) of the treatment machine. If this is a file name, the default path to the file is added. If it is a full path, then the full path is returned.
%
%
%% Output arguments
%
% |pluginPath| - _STRING_ -  The full path to the root folder of the MCsquare plugin
%
% |MCsqExecPath| - _STRING_ -  The full path to the MCsqaure executables
%
% |BDLPath| - _STRING_ -  The full path to the file (if |Plan| is provided) or the folder containing the beam data library
%
% |MaterialsPath| - _STRING_ -  The full path to the folder where the amterial fiels are stored
%
% |ScannersPath| - _STRING_ -  The full path to the file (if |Plan| is provided) or the folder containing the scanner calibration file
%
%
%% Contributors
% Authors : R. Labarbe (open.reggui@gmail.com)


function [pluginPath , MCsqExecPath , BDLPath , MaterialsPath , ScannersPath] = get_MCsquare_folders(Scanner , BDL)

    %Define the default folders
    pluginPath = getPluginPath('openMCsquare');
    MCsqExecPath = fullfile(pluginPath , 'lib');
    BDLPath = fullfile(pluginPath , 'lib','BDL');
    MaterialsPath = fullfile(pluginPath , 'lib','Materials');
    ScannersPath = fullfile(pluginPath , 'lib','Scanners');

    %BDLPath and ScannersPath are forwarded to MCsquare via the config.txt file with the parameters BDL_Machine_Paramete, HU_Material_Conversion_File, HU_Density_Conversion_File.
    % The function Generate_MC2_Config create the config file.

    %MCsqaure looks for the Material files in two locations:
    % 1) First it can be a sub folder of the current folder. It looks for the file  ./Materials/list.dat
    % 2) If not in the current folder, using environment variable of the operating system.
    % The scripts 'MCsquare' or MCsquare.bat defines the environment variable 'MCsquare_Materials_Dir' with a sub folder /Materials in a folder of the script 'MCsquare'.


    %If a Scanner folder was prodived, process it
    if nargin >=1 && ~isempty(Scanner)

        %Use 'isfolder' or 'isfile' and not 'exist' because 'exist' also look for folder or file in the PATH.
        %We search only for folder in pwd or provided with full name
        if isfolder(fullfile(pwd,Scanner))
            %This is a subfolder of the present working director
            ScannersPath = fullfile(pwd,Scanner);
        elseif isfolder(Scanner)
          %We received the full path. Just copy it
          ScannersPath = Scanner;
        else
          %This is not a full path to a folder
          %Check whether it is a sub-folder in the default scanner folder
          ScannersPath = fullfile(ScannersPath, Scanner);
          if ~isfolder(ScannersPath)
            fprintf('Scanner folder : %s \n', ScannersPath)
            error('Folder does not exist')
          end
        end
    end

    %If a BDL file is provided, process it
    if nargin >=2 && ~isempty(BDL)

        if isfile(fullfile(ScannersPath , BDL))
           %This is a file in the |ScannersPath| folder
           BDLPath = fullfile(ScannersPath , BDL);
        elseif isfile(BDL)
          %We received the full path. Just copy it
          BDLPath = BDL;
        else
          %This is only the file name. Look in the default folders
          BDLPath = fullfile(BDLPath, BDL);
          if ~isfile(BDLPath)
            fprintf('BDL file : %s \n', BDLPath)
            error('File does not exist')
          end
        end
    end

end
