# Ansible Best Practices Guide for SRE Team

## Introduction
This document outlines the best practices for using Ansible within our SRE team. It serves as a guide for writing efficient, maintainable, and reusable Ansible code.

## Table of Contents
- [YAML for Inventories](#yaml-for-inventories)
- [Defining Roles](#defining-roles)
- [Naming Conventions](#naming-conventions)
  - [Roles](#roles)
  - [Playbooks](#playbooks)
  - [Tags](#tags)
  - [Variables](#variables)
  - [Tasks](#tasks)
- [Directory Structure](#directory-structure)
  - [Playbooks](#playbooks-1)
  - [Roles](#roles-1)
  - [Variables](#variables-1)
- [Best Practices](#best-practices)
  - [Using Tags](#using-tags)
  - [Variable Management](#variable-management)
  - [Importing Roles](#importing-roles)
  - [Error Handling](#error-handling)
  - [Task Formatting](#task-formatting)

## 0.0.0: Main principles
### 0.0.1: When simple is possible, do it simple.
### 0.0.2: Do not expose sensitive information without vault.
### 0.0.3: Keep in mind that what ever you are making is for someone else and not you.
### 0.0.4: We start counting from `1` and not `0`.






## 1.0.0: Inventories
### 1.0.1: 
  * YAML is preferred over INI for inventories due to its readability and support for complex data structures. This format enhances clarity and maintainability.
### 1.0.2:
  * Use seperate inventory files for each services on each component rather than using one huge inventory file
    * As an example: `Kafka_Inventory_Zone_1_Stage.yaml`


## 2.0.0: Roles
### 2.0.1:
  * A role in Ansible is a set of tasks and additional files to configure a host to serve a specific purpose. Following the `SOLID` principle, each role should have a single responsibility, be open for extension but closed for modification, and be interchangeable.
    * Solid principles: 
      1. Single Responsibility Principle (SRP): Each Ansible role or task should have one specific job
      2. Open-Closed Principle (OCP): Ansible roles should be designed to be extendable. You should be able to add new features or functionalities to a role without modifying the existing code
      3. Liskov Substitution Principle (LSP): This principle is more relevant to object-oriented programming and might not apply directly to Ansible. However, the concept of substitutability can be applied to Ansible roles. For example, you should be able to replace one role with another that performs a similar function without affecting the rest of the system
      4. Interface Segregation Principle (ISP): Ansible roles should be designed to be as small and focused as possible.
      5. Dependency Inversion Principle (DIP): High-level playbooks should not depend on low-level roles. Instead, both should depend on abstract roles.

### 2.0.2:
  * All role names must be expressive of their nature and what they are supposed to do.
    * As an example: `elasticsearch_deploy_exporter`

### 2.0.3:
  * For sensitive tasks, a moderate use of debug module is appriciated.

### 2.0.4:
  * Add the following task to the beginning of every role.
    ```bash
    - name: Check connectivity
      ping:
        data: alive
    ```
### 2.0.5:
  * All role names must be lowercase and alphanumerical; also they must start with a letter.
    * As an example: `elasticsearch_deploy_exporter`

 ### 2.0.6:
  * All tasks must have names
    
 ### 2.0.7:
  * Task names must start with uppercase letter.
    * As an example: `Check connectivity`

 ### 2.0.8:
  * No role should contain more than 20 tasks unless they are for debugging purposes
    

## 3.0.0: Playbooks
### 3.0.1: 
  * Use different playbooks for different class of operations on a component.
    * As an example: `Elasticsearch_Deploy_Exporter`
### 3.0.2:
  * All role names must be expressive of their nature.
    * As an example: `Elasticsearch_Initial_Deployment.yaml`


## 4.0.0: Tags
### 4.0.1:
  * Use tags for operation related to maintaining a service (Not initial deployments).
### 4.0.2:
  * Tags names are a combination of a component name and the action which it is going to do.
    * As an example: `Docker:Pull`


## 5.0.0: Variable Management
### 5.0.1:
  * Avoid default values for variables. Always provide descriptive comments for each variable.
### 5.0.2:
  * All variables must be lowercase. 
    * As an example: `kafka_base_image`
### 5.0.3:
  * If there is an alternate value for a variable, please use comments and provide the possible values for that particular variable.
    * As an example: `kafka_exporter_base_image: bitnami/kafka-exporter #danielqsj/kafka-exporter`
### 5.0.4:
  * If you are providing a directory path as the value for a variable, always use the final "/"
    * As an example: `kafka_certs_directory: /root/Kafka/Config/Certs/`
### 5.0.5:
  * Use seperate variable files for each component and be descriptive in naming the file.
    * As an example: `Kafka_Variables_Production.yaml`

  

## 6.0.0: Directory Structure

### 6.0.1: 
  * Overview of the project 
    ```bash
    Ansible_Project/
      ├─ Playbooks/
        ├─ Elasticsearch/
        │  ├─ Elasticsearch_Initial_Deployment.yaml
        │  ├─ Elasticsearch_Update_Certificates.yaml
        │  ├─ Elasticsearch_Rebalance_Shards.yaml
        │
        │
        ├─ Redis/
        │  ├─ Redis_Initial_Deployment.yaml
        │  ├─ Redis_Update_Certificates.yaml
        │
      ├─ Roles/
        ├─ General/
        │  ├─ Node_Pre_Setup
        │  ├─ Node_Hardening
        │  ├─ Install_Docker_Ubuntu
        │
        │
        ├─ Redis/
        │  ├─ Redis_Cluster_Initial_Deployment_Dockerized
        │  ├─ Redis_Exporter_Setup_Dockerized
        │
        │
        ├─ Clickhouse/
        │  ├─ Clickhouse_Deploy_Dockerized
        │  ├─ Clickhouse_Exporter_Setup_Dockerized
        │
      ├─ Inventories/
        ├─ Zone_1/
        │  ├─ Stage/
        │  │   ├─ Elasticsearch/
        │  │   │  ├─ Zone_1_Elasticsearch_Stage_Inventory.yaml
        │  │   ├─ Clickhouse
        │  │   │  ├─ Zone_1_Clickhouse_Stage_Inventory.yaml
        │  │   ├─ Redis
        │  │   │  ├─ Zone_1_Redis_Stage_Inventory.yaml
        │  ├─ Production/
        │  │   ├─ Elasticsearch/
        │  │   │  ├─ Zone_1_Elasticsearch_Production_Inventory.yaml
        │  │   ├─ Clickhouse/
        │  │   │  ├─ Zone_1_Clickhouse_Production_Inventory.yaml
        │  │   ├─ Redis/
        │  │   │  ├─ Zone_1_Redis_Production_Inventory.yaml
        │  │
        │  │
        ├─ Zone_2/
        │  ├─ Stage/
        │  │   ├─ Elasticsearch/
        │  │   │  ├─ Zone_2_Elasticsearch_Stage_Inventory.yaml
        │  │   ├─ Clickhouse
        │  │   │  ├─ Zone_2_Clickhouse_Stage_Inventory.yaml
        │  │   ├─ Redis
        │  │   │  ├─ Zone_2_Redis_Stage_Inventory.yaml
        │  ├─ Production/
        │  │   ├─ Elasticsearch/
        │  │   │  ├─ Zone_2_Elasticsearch_Production_Inventory.yaml
        │  │   ├─ Clickhouse/
        │  │   │  ├─ Zone_2_Clickhouse_Production_Inventory.yaml
        │  │   ├─ Redis/
        │  │   │  ├─ Zone_2_Redis_Production_Inventory.yaml
        │  │
        │  │
        │
    ```
### 6.0.2: 
  * Each part of a services must be in a logically seperated directory 

    ```bash
    
    root/
      ├─ Kafka/
      │  ├─ Config/
      │  │   ├─ Certs
      │  │   │   ├─ ca-cert
      │  │     
      │  │─ Docker   
      │  │  ├─ docker-compose.yaml
      │  │
      │  │─ Exporter
      │  │  │─ Docker 
      │  │  │  ├─ docker-compose.yaml
      │  ├─ Gui/
      │  │  │─ Docker 
      │  │  │  ├─ docker-compose.yaml
    
    ```





## 7.0.0: Agreed Upon Practices

### 7.0.1: 
  * When working with containers, use docker compose template instead of directly running the container so this way the service would be much easier to manager in the future

### 7.0.2: 
  * Prefer `include_roles` over `import_roles` or `roles` for better performance and readability.

### 7.0.3:
  * Set `any_errors_fatal: true` to ensure clean execution of playbooks.

### 7.0.4: 
  * Use `command` instead of `shell` since command is faster.

### 7.0.5: 
  * Use `delegate_to` instead of `local_action`.

### 7.0.6: 
  * Use `delegate_to` instead of `local_action`.

### 7.0.7: 
  * Do not use empty string comparission.
    * As an example: `when: var | lengh > 0` instead of `when: var != ""`

### 7.0.8: 
  * Do not use `ignore_errors=True`; instead use `failed_when`.
    
### 7.0.9: 
  * Do not use inline variables, instead include the variable in the vars file.
    
### 7.1.0: 
  * Unless there is a good reason, do not use latest, explicitly specify the version for all packages and images.
    
### 7.1.1: 
  * Use `when: var != True` instead of `when: not var`.

### 7.1.2: 
  * Use `when: var != True` instead of `when: not var`.

### 7.1.3: 
  * Use `no_log=True` for sensitive information so they wont be exposed when a play is running.

### 7.1.4: 
  * Do not prompt for anything so the play can also be used in CI/CD if needed.

### 7.1.5: 
  * Explicitly specify paths and do not use relative addressing.

### 7.1.6: 
  * Explicitly specify paths and do not use relative addressing.

### 7.1.7: 
  * Use `pipefail` when piping the output of a command to another so if the first command failed the whole task would be failed.

### 7.1.8: 
  * Explicitly specify paths and do not use relative addressing.

### 7.1.9: 
  * on playbooks, do not specify the path to the role and leave it to ansible to find the role.






