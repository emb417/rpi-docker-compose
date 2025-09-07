# Docker Compose Project

This repository serves as the central orchestration point for a multi-repository, containerized application stack. It uses **Docker Compose** to manage the primary services, which are housed in their own sibling repositories: `rpi-nginx`, `metaforiq-next`, and `metaforiq-node`.

---

## Project Purpose

The primary goal of this setup is to create a consistent, portable, and efficient development environment. By keeping each service in a separate repository, teams can work independently, while this repository ensures a cohesive and repeatable way to run the entire stack locally or in a CI/CD environment.

---

## Prerequisites

To run this project, you need the following software installed on your machine:

- Docker
- Docker Compose

---

## Getting Started

There are two primary ways to run this project, depending on your goal.

### Option 1: Production Deployment

This is the recommended approach for production, as it pulls pre-built Docker images from a container registry. This ensures all environments are running the same, tested versions of the services and is crucial for a robust CI/CD pipeline.

**Clone the Repository:**

```bash
git clone https://github.com/emb417/rpi-docker-compose.git
cd rpi-docker-compose
```

**Ensure Configuration Files Exist:**
Before starting, ensure you have the `metaforiq-next.env`, `metaforiq-node.env`, and `db.json` files in the same directory as this `docker-compose.yml` file.

**Pull and Start the Services:**
This command will download the latest images from Docker Hub and start the services in detached mode.

```bash
docker compose pull
docker compose up -d
```

---

### Option 2: Local Development Build

This is for developers who need to make changes to a service and test them locally. You must have the sibling repositories cloned to your machine in the same parent directory. This approach gives you real-time visibility into the logs for each service, which is essential for debugging.

**Clone All Repositories:**

```bash
git clone https://github.com/emb417/rpi-docker-compose.git
git clone https://github.com/emb417/rpi-nginx.git
git clone https://github.com/emb417/metaforiq-next.git
git clone https://github.com/emb417/metaforiq-node.git
```

This ensures all repositories are siblings.

**Build the Images:**
This command will build the Docker images for all services using the local configuration file.

```bash
docker compose -f docker-compose-local.yml build
```

> **Note:** This command assumes the local configuration file is named `docker-compose-local.yml`.

**Start the Services (with Local Configuration):**
Run this command without the `-d` flag to see the combined logs from all services in your terminal. This command uses a specific local configuration file that references `default-local.conf`.

```bash
docker compose -f docker-compose-local.yml up
```

> **Note:** This command assumes the local configuration file is named `docker-compose-local.yml` and that it is configured to use the `default-local.conf` file.

**Stop the Services:**

```bash
docker compose down
```

**Clean Up:**

```bash
docker compose down -v
```

This will remove any volumes associated with the services.

---

## Data Management

The `metaforiq-node` service uses a Docker named volume for data persistence. This ensures that the `db.json` file is stored safely on the server, independent of the container itself. This is the recommended approach for a production environment.

### One-Time Data Import

To seed your production volume with data from your local `db.json` file, you must perform a one-time copy. This process uses a temporary container to access both your local file and the named volume.

**Stop all services:**
Ensure your services are not running to avoid file-locking conflicts.

```bash
docker compose down
```

**Copy the data into the volume:**
Run this command from the `rpi-docker-compose` directory. This will copy `db.json` from your local machine to the named volume.

```bash
docker run --rm \
  -v "$(pwd):/source" \
  -v rpi-docker-compose_metaforiq-node-data:/destination \
  alpine \
  cp /source/db.json /destination/
```

### Backing Up Data

To back up your `db.json` file from the production volume to the `backups` folder, you can use a similar process.

**Copy the data from the volume to your local machine:**

```bash
docker run --rm \
  -v rpi-docker-compose_metaforiq-node-data:/source \
  -v "$(pwd)/backups:/destination" \
  alpine \
  cp /source/db.json /destination/db.json
```
