

# Capstone Project: CloudUploader CLI

The CloudUploader CLI is a bash-based command-line tool that allows users to quickly upload files to a specified cloud storage solution. It’s designed for simplicity, security, and efficiency, offering a streamlined experience similar to popular cloud storage services.

## Project Overview

### GitHub Repository

The project was developed using a dedicated GitHub repository with branches for feature development and frequent commits to maintain a clear version history.

### Setup & Authentication

I selected  Azure Blob Storage for the cloud storage solution. Authentication was securely managed through environment variables and cloud provider methods like [insert method, e.g., `az login`] to ensure credentials were handled safely.

### CLI Argument Parsing

The tool accepts command-line arguments to specify the file to upload:

```bash
clouduploader /path/to/file.txt
```

It validates the file path and checks for additional options like target directories, ensuring correct and accessible inputs.

### File Upload & Feedback

The CLI uses the cloud provider’s CLI to upload files, handling any errors and providing clear feedback on success or failure.

