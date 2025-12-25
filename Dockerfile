FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for Docker layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY demo/ ./demo/
COPY vectorstore/ ./vectorstore/
COPY data/main-data/synthetic-resumes.csv ./data/main-data/

# Set default environment variables (can be overridden)
ENV PORT=8501
ENV DATA_PATH=data/main-data/synthetic-resumes.csv
ENV FAISS_PATH=vectorstore
ENV EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2

# Expose port
EXPOSE 8501

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl --fail http://localhost:8501/_stcore/health || exit 1

# Run Streamlit
CMD streamlit run demo/interface.py --server.port=$PORT --server.address=0.0.0.0 --server.headless=true

