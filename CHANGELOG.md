# Changelog

## 0.0.1 (2025-05-22)

### Features
 - Beginning Change Log (This File)
 - Adjust Windows Server Module - added required variables 
 - Add AWS Transit Gateway (Non-HA) ./modules/cato/vsocket-tgw
 - Add AWS Transit Gateway HA ./modules/cato/vsocket-tgw-ha
 - Run Tests against both TGW Deployments 
 - Update Readme with Run-Times for TGW Deployments 
 - Update aws tf example main file with examples for tgw deployments 
 - Update terraform.tfvars.example file with updated vars for tgw deployments
 - Update variables.global.tf with updated vars for tgw deployments 
 - Update versions file to use latest aws provider (~>5.98)
 - Add TODO.md File to track needs within the Repo

## 0.0.2 (2025-05-22)

## Fixes
 - Fixed syntax issue for output in socket-csv module for interface_id
 - Removed unnecessary var for build_socket_module

## 0.0.3 (2025-05-23)

### Features
 - Added Testing Env for TGW 
 - Added Testing Env for TGW-HA
 - Added Docs for Testing Env for TGW
 - Added Docs for Testing Env for TGW-HA
 - Update ToDo

## 0.0.4 (2025-06-05)

### Features
 - Added IPSEC to TGW 
 - Added Testing Env for IPSEC to TGW 
 - Added Docs for Testing Env for IPSEC to TGW
 - Updated ToDo

## 0.0.5 (2025-06-06)

### Features
 - Updated to use newest Azure Modules 
 - Updated Azure Examples to use 'Location' 