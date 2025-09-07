# Docker Compose Project

This repository serves as the central orchestration point for a multi-repository, containerized application stack. It uses Docker Compose to manage the primary services, which are housed in their own sibling repositories: `rpi-nginx`, `metaforiq-next`, and `metaforiq-node`.

## Project Purpose

The primary goal of this setup is to create a consistent, portable, and efficient development environment. By keeping each service in a separate repository, teams can work independently, while this repository ensures a cohesive and repeatable way to run the entire stack locally or in a CI/CD environment.

## Prerequisites

To run this project, you need the following software installed on your machine:

- **Docker**
- **Docker Compose**

---

## Getting Started

There are two primary ways to run this project, depending on your goal.

### Option 1: Production Deployment

This is the recommended approach for production, as it pulls pre-built Docker images from a container registry. This ensures all environments are running the same, tested versions of the services and is crucial for a robust CI/CD pipeline.

1. **Clone the Repository:**

   ```bash
   git clone [https://github.com/emb417/rpi-docker-compose.git](https://github.com/emb417/rpi-docker-compose.git)
   cd rpi-docker-compose
   ```

2. **Ensure Configuration Files Exist:**
   Before starting, ensure you have the `metaforiq-next.env`, `metaforiq-node.env`, and `db.json` files in the same directory as this `docker-compose.yml` file.

3. **Pull and Start the Services:**
   This command will download the latest images from Docker Hub and start the services in detached mode.

   ```bash
   docker compose pull
   docker compose up -d
   ```

### Option 2: Local Development Build

This is for developers who need to make changes to a service and test them locally. You must have the sibling repositories cloned to your machine in the same parent directory. This approach gives you real-time visibility into the logs for each service, which is essential for debugging.

1. **Clone All Repositories:**

   ```bash
   git clone [https://github.com/emb417/rpi-docker-compose.git](https://github.com/emb417/rpi-docker-compose.git)
   git clone [https://github.com/emb417/rpi-nginx.git](https://github.com/emb417/rpi-nginx.git)
   git clone [https://github.com/emb417/metaforiq-next.git](https://github.com/emb417/metaforiq-next.git)
   git clone [https://github.com/emb417/metaforiq-node.git](https://github.com/emb417/metaforiq-node.git)
   ```

   This ensures all repositories are siblings.

2. **Build the Images:**
   This command will build the Docker images for all services from their local `Dockerfile`s.

   ```bash
   docker compose build
   ```

3. **Start the Services:**
   Run this command **without** the `-d` flag to see the combined logs from all services in your terminal. This is critical for real-time debugging.

   ```bash
   docker compose up
   ```

4. **Stop the Services:**

   ```bash
   docker compose down
   ```

5. **Clean Up:**

   ```bash
   docker compose down -v
   ```

   This will remove any volumes associated with the services.
