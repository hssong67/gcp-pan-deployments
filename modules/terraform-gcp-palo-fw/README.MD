# GCP Palo NGFW Deployment Module
A module designed to ease the deployment of a PAN NGFW Instancesf

## Usage
This module's intent is to stream line the deployment of PAN NGFW inside GCP. While exposing several input variables for customization without requiring so much code. It is recommend that the user look at the latest supported versions of image deployment from GCP API call `gcloud compute images list --project paloaltonetworksgcp-public --no-standard-images`. Supported values as of this release are in the table below:  
__NOTE:__ Default image is __Bundle1__ version __9.0.4__

### Supported Deployments
The version will be indicated by three consecutive integers, while the license
type is to by indicated by the string listed. _i.e. byol 810_
| License | Version |
-----------
| BYOL | 8.1.0 |
| BYOL | 8.1.4 |
| BYOL | 8.1.9 |
| BYOL | 9.0.1 |
| BYOL | 9.0.4 |
| Bundle1 | 8.1.0 |
| Bundle1 | 8.1.4 |
| Bundle1 | 8.1.9 |
| Bundle1 | 9.0.1 |
| Bundle1 | 9.0.4 |
| Bundle2 | 8.1.0 |
| Bundle2 | 8.1.4 |
| Bundle2 | 8.1.9 |
| Bundle2 | 9.0.1 |
| Bundle2 | 9.0.4 |

## TODO
* Count
* Unmanaged Instance Groups
* Managed Instance Groups

