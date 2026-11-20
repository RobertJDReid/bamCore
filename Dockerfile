FROM python:3.10-slim

# Metadata
LABEL maintainer="Robert J. D. Reid"
LABEL version="0.3.5"
LABEL description="bamCore.py - Extract per-read base calls from BAM files"

# Install system dependencies required for pysam
RUN apt-get update && apt-get install -y \
    gcc \
    libbz2-dev \
    liblzma-dev \
    zlib1g-dev \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pysam and tqdm (progress bar)
RUN pip install --no-cache-dir pysam tqdm

# Create app directory
WORKDIR /app

# Copy the script. bamCore.py in the repo is a symlink to the versioned file,
# which does not resolve on other machines, so copy the versioned file directly.
COPY bamCore_v0.3.5.py /app/bamCore.py

# Set the entrypoint to run bamCore.py
ENTRYPOINT ["python", "/app/bamCore.py"]

# Default command shows help if no arguments provided
CMD ["--help"]
