#!/bin/bash

# Function to prompt the user for a variable value
prompt_for_variable() {
    local env_name=$1
    local variable_name=''
    local description=$2

    echo 
    echo $description
    
    # Read input with tab auto-completion
    read -e -p "Enter the value for $env_name: " variable_name

    # If the user entered nothing, skip the configuration
    if [[ -z "$variable_name" ]]; then
        echo "Configuration for $env_name will be skipped as you input nothing."
        return
    fi

    variable_name=${variable_name%%\/}
    echo "variable_name: ${variable_name}"

    # Write the value to ~/.bash_profile
    echo
    echo "export $env_name='${variable_name}'" >> ~/.bash_profile
    # Add the variable to PATH
    echo 'export PATH=$PATH:$'$env_name/bin >> ~/.bash_profile
}

# Example usage:
prompt_for_variable "JAVA_HOME"     'JAVE_HOME is the Java installation directory which contains `lib`, `bin` and other folders.'
prompt_for_variable "MAVEN_HOME"    'MAVEN_HOME is the extracted Maven directory which contains `lib`, `bin` and other folders.'
prompt_for_variable "ANT_HOME"      'ANT_HOME is the extracted Ant directory which contains `lib`, `bin` and other folders.'
prompt_for_variable "CATALINA_HOME" 'CATALINA_HOME is the extracted TomEE directory which contains `lib`, `bin` and other folders.'

# Reload ~/.bash_profile
source ~/.bash_profile