# 🚀 Deployment Guide for AI Resume Screener Pro

## Deployment Options

### 1. **Streamlit Cloud (Recommended - Free)**
✅ **Best for:** Quick deployment, free hosting  
⚠️ **Limitations:** 
- 1GB memory limit (free tier)
- May have timeout issues with large datasets
- First deployment takes 30-60 min (package installation)

### 2. **AWS/GCP/Azure**
✅ **Best for:** Production, larger datasets, better performance  
⚠️ **Requirements:** Cloud account, configuration needed

### 3. **Docker + Any Cloud**
✅ **Best for:** Portability, containerized deployment

---

## 📊 Current Project Size Analysis

- **Total Size:** ~386MB
- **Vectorstore:** ~5.2MB (essential)
- **Main Data:** 1.4MB (synthetic-resumes.csv - essential)
- **Evaluation Data:** ~140MB (NOT needed for deployment)
- **Dependencies:** Large (sentence-transformers ~500MB, faiss-cpu ~100MB)

## ✅ What Streamlit Can Handle

**YES, Streamlit can handle this:**
- ✅ Vectorstores (5.2MB) - Small enough
- ✅ CSV files (1.4MB default) - Fine
- ✅ Lazy loading (already implemented) - Good
- ✅ Large dependencies - Will install on first deploy

**Optimizations Needed:**
- ❌ Remove evaluation data (140MB) - Not needed
- ❌ Remove duplicate vectorstores - Keep only one
- ✅ Keep lazy loading for embeddings

---

## 🎯 Streamlit Cloud Deployment Steps

### Step 1: Prepare Repository

1. **Create a GitHub repository** (if not already done)
2. **Ensure these files are in `.gitignore`:**
   - `data/main-data/gpt*/` (evaluation data)
   - `data/supplementary-data/` (not needed)
   - `vectorstore-pdf/`, `vectorstore-synthetic/` (if you have main vectorstore)
   - `.env` (use Streamlit secrets instead)

### Step 2: Create Deployment Files

Create these files in your repo root:

**`.streamlit/config.toml`** (optional - for settings):
```toml
[server]
maxUploadSize = 200
maxMessageSize = 200

[browser]
gatherUsageStats = false
```

**`packages.txt`** (for system packages - optional):
```
# Only if you need system-level packages
```

### Step 3: Deploy on Streamlit Cloud

1. Go to [share.streamlit.io](https://share.streamlit.io)
2. Click "New app"
3. Connect your GitHub repository
4. Set:
   - **Main file path:** `demo/interface.py`
   - **Python version:** 3.9 or higher
5. Click "Advanced settings" and add secrets:

```
OPENAI_API_KEY=sk-your-key-here
DATA_PATH=data/main-data/synthetic-resumes.csv
FAISS_PATH=vectorstore
EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2
```

6. Click "Deploy"

### Step 4: First Deployment

- ⏱️ **First deployment takes 30-60 minutes** (installing large packages)
- ✅ After first deploy, subsequent deploys are faster (~5-10 min)
- 📊 Monitor deployment logs for any errors

---

## 🐳 Docker Deployment (Alternative)

Create `Dockerfile`:

```dockerfile
FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY demo/ ./demo/
COPY vectorstore/ ./vectorstore/
COPY data/main-data/synthetic-resumes.csv ./data/main-data/
COPY .env.example .env

# Expose Streamlit port
EXPOSE 8501

# Health check
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

# Run Streamlit
ENTRYPOINT ["streamlit", "run", "demo/interface.py", "--server.port=8501", "--server.address=0.0.0.0"]
```

**Build and run:**
```bash
docker build -t resume-screener .
docker run -p 8501:8501 -e OPENAI_API_KEY=sk-... resume-screener
```

---

## 📦 Files to Include/Exclude for Deployment

### ✅ **Include (Essential):**
```
demo/
├── interface.py
├── llm_agent.py
├── retriever.py
├── ingest_data.py
└── chatbot_verbosity.py

vectorstore/
├── index.faiss (~3.3MB)
└── index.pkl (~1.9MB)

data/main-data/
└── synthetic-resumes.csv (~1.4MB)

requirements.txt
README.md
```

### ❌ **Exclude (Not needed for deployment):**
```
data/main-data/gpt*/          # Evaluation data (~140MB)
data/supplementary-data/      # Extra data (~20MB)
vectorstore-pdf/              # Duplicate vectorstore
vectorstore-synthetic/        # Duplicate vectorstore
evaluation/                   # Evaluation notebooks
preprocessing/                # Data preprocessing
*.ipynb                       # Jupyter notebooks
.env                          # Use secrets instead
```

---

## ⚡ Performance Optimization Tips

### 1. **Already Implemented:**
- ✅ Lazy loading of embedding model
- ✅ Lazy loading of vectorstore
- ✅ Session state caching

### 2. **Additional Optimizations (Optional):**

**Reduce initial load time:**
- Pre-load vectorstore in a startup script
- Use smaller embedding model for faster startup

**Reduce memory usage:**
- Limit number of resumes in default dataset
- Use streaming for large result sets

---

## 🔒 Security Checklist

- ✅ API key in secrets (not in code)
- ✅ `.env` in `.gitignore`
- ✅ No hardcoded credentials
- ⚠️ Consider rate limiting for production
- ⚠️ Add authentication for production use

---

## 📈 Scaling Considerations

**Current Setup (Good for):**
- Small to medium datasets (<10,000 resumes)
- Low to moderate traffic (<100 concurrent users)
- Streamlit Cloud free tier

**For Larger Scale:**
- Use dedicated cloud instance (AWS/GCP)
- Consider Redis for session state
- Use managed vector database (Pinecone, Weaviate)
- Add caching layer (Redis/Memcached)

---

## 🆘 Troubleshooting

### Issue: Deployment timeout
**Solution:** First deploy always takes longer. Wait 30-60 minutes.

### Issue: Out of memory
**Solution:** 
- Remove unnecessary data files
- Use smaller embedding model
- Enable lazy loading (already done)

### Issue: API key not working
**Solution:**
- Check Streamlit secrets are set correctly
- Ensure `.env` file is not committed to git
- Verify API key format in secrets

### Issue: Vectorstore not found
**Solution:**
- Ensure `vectorstore/` folder is committed to git
- Check `FAISS_PATH` in secrets matches actual path

---

## 📞 Support

For deployment issues:
1. Check Streamlit Cloud logs
2. Verify all required files are in repository
3. Check secrets are set correctly
4. Review error messages in deployment logs

