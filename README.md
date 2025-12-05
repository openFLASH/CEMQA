# CEMQA
CT based CEM QA : this script uses a CT of a CEM and compares to the reference from a ConformalFLASH DICOM plan to verify its dimensional accuracy. It is based on and makes use of the REGGUI framework, whose dependencies are included here, so that this project is standalone. 

## Requirements

* Matlab 
* Image Processing toolbox

## Getting started

After cloning the git:
* En the folder `resources`, unzip the file CT_air.zip
* Add the whole folder and subfolders in the Matlab path
* Call the script `CEMQA`, providing the 3 inputs in command line. 

Example: `CEMQA('c:\data\example\CT_CEM\CT_0001.dcm', 'c:\data\example\RP.dcm', 'c:\data\example\output\')`

## Config
The only config is the CT scanner. A default configuration is included (folder `resources\Scanner`).
Please overwrite it with the configuration with the CT scanner used. 

## Prerequisites on the CEM CT
The CEM has to be scanned following these guidelines:
* The arrow has to point towards the head
* The base place has to be elevated with lateral support or on a light material, for easy separation from the table
* The lateral ridges have to be cropped out of the CT

## Inputs
* scanCEM_path : the path to the CEM CT (path to a single file of the DICOM series; any is fine)
* RSplanFileName : the path to the ConformalFLASH treatment plan (DICOM)
* outputPath : path to an empty folder to place the outputs

## Outputs
* A series of figures will open, and will be saved in .jpg in the output folder
* A series of .dcm files
* A summary.txt file with the main metrics


## License

This software is distributed under LGPL-3.0 license. Please read about it in the tab "License".
In short: about all uses are permitted, but all changes have to be published and documented under LGPL-3.0 as well.
