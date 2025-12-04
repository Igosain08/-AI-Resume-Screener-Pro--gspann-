# 🚀 Deployment Guide - AI Resume Screener Pro

Complete guide to deploy your AI Resume Screener Pro application.

---

## 📋 Pre-Deployment Checklist

- [x] ✅ Code pushed to GitHub
- [x] ✅ .env file excluded (sensitive data)
- [x] ✅ .gitignore configured
- [x] ✅ All dependencies in requirements.txt
- [x] ✅ README updated

---

## 🌐 Deployment Options

### Option 1: Streamlit Cloud (Recommended - Free & Easy)

**Best for**: Quick deployment, free hosting, automatic updates

#### Steps:

1. **Go to Streamlit Cloud**
   - Visit: https://streamlit.io/cloud
   - Sign in with GitHub

2. **Connect Your Repository**
   - Click "New app"
   - Select your repository: `Igosain08/-AI-Resume-Screener-Pro--gspann-`
   - Branch: `main`
   - Main file path: `demo/interface.py`

3. **Configure Environment Variables**
   - In Streamlit Cloud settings, add:
     ```
     DATA_PATH=data/main-data/synthetic-resumes.csv
     FAISS_PATH=vectorstore
     EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2
     ```
   - **Important**: Users will need to add their own OpenAI API key in the app

4. **Deploy**
   - Click "Deploy"
   - Wait for build to complete
   - Your app will be live at: `https://your-app-name.streamlit.app`

#### Pros:
- ✅ Free
- ✅ Automatic deployments on git push
- ✅ Easy to set up
- ✅ HTTPS included
- ✅ Custom subdomain

#### Cons:
- ⚠️ Public by default (can be private with paid plan)
- ⚠️ Limited resources on free tier

---

### Option 2: Heroku

**Best for**: More control, custom domain, scaling options

#### Steps:

1. **Install Heroku CLI**
   ```bash
   # macOS
   brew tap heroku/brew && brew install heroku
   
   # Or download from: https://devcenter.heroku.com/articles/heroku-cli
   ```

2. **Login to Heroku**
   ```bash
   heroku login
   ```

3. **Create Heroku App**
   ```bash
   cd Resume-Screening-RAG-Pipeline
   heroku create your-app-name
   ```

4. **Create Procfile**
   Create a file named `Procfile` (no extension):
   ```
   web: streamlit run demo/interface.py --server.port=$PORT --server.address=0.0.0.0
   ```

5. **Create setup.sh**
   Create `setup.sh`:
   ```bash
   mkdir -p ~/.streamlit/
   echo "\
   [server]\n\
   port = $PORT\n\
   enableCORS = false\n\
   headless = true\n\
   \n\
   " > ~/.streamlit/config.toml
   ```

6. **Set Environment Variables**
   ```bash
   heroku config:set DATA_PATH=data/main-data/synthetic-resumes.csv
   heroku config:set FAISS_PATH=vectorstore
   heroku config:set EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2
   ```

7. **Deploy**
   ```bash
   git push heroku main
   ```

#### Pros:
- ✅ Custom domain support
- ✅ More control
- ✅ Scaling options
- ✅ Add-ons available

#### Cons:
- ⚠️ Free tier discontinued (paid plans start at $7/month)
- ⚠️ More complex setup

---

### Option 3: AWS EC2 / Google Cloud / Azure

**Best for**: Enterprise, high traffic, full control

#### AWS EC2 Steps:

1. **Launch EC2 Instance**
   - Choose Ubuntu 22.04 LTS
   - t2.medium or larger (for ML models)
   - Configure security group (open port 8501)

2. **SSH into Instance**
   ```bash
   ssh -i your-key.pem ubuntu@your-ec2-ip
   ```

3. **Install Dependencies**
   ```bash
   sudo apt update
   sudo apt install python3-pip python3-venv -y
   ```

4. **Clone and Setup**
   ```bash
   git clone https://github.com/Igosain08/-AI-Resume-Screener-Pro--gspann-.git
   cd -AI-Resume-Screener-Pro--gspann-
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

5. **Create .env file**
   ```bash
   nano .env
   # Add your environment variables
   ```

6. **Run with Screen/Tmux**
   ```bash
   screen -S streamlit
   streamlit run demo/interface.py --server.port=8501 --server.address=0.0.0.0
   # Press Ctrl+A then D to detach
   ```

7. **Access**
   - Visit: `http://your-ec2-ip:8501`

#### Pros:
- ✅ Full control
- ✅ Scalable
- ✅ Custom domain
- ✅ High performance

#### Cons:
- ⚠️ Requires server management
- ⚠️ Costs money (pay per use)
- ⚠️ More complex

---

### Option 4: Docker + Any Cloud Provider

**Best for**: Containerized deployment, consistent environments

#### Steps:

1. **Create Dockerfile**
   ```dockerfile
   FROM python:3.9-slim
   
   WORKDIR /app
   
   COPY requirements.txt .
   RUN pip install --no-cache-dir -r requirements.txt
   
   COPY . .
   
   EXPOSE 8501
   
   HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health
   
   ENTRYPOINT ["streamlit", "run", "demo/interface.py", "--server.port=8501", "--server.address=0.0.0.0"]
   ```

2. **Create .dockerignore**
   ```
   __pycache__
   *.pyc
   .env
   .git
   venv
   *.csv
   vectorstore
   ```

3. **Build and Run**
   ```bash
   docker build -t resume-screener .
   docker run -p 8501:8501 -e DATA_PATH=data/main-data/synthetic-resumes.csv \
     -e FAISS_PATH=vectorstore \
     -e EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2 \
     resume-screener
   ```

4. **Deploy to Cloud**
   - AWS ECS, Google Cloud Run, Azure Container Instances
   - Follow respective platform's Docker deployment guide

---

## 🔒 Security Considerations

### Before Deploying:

1. **Environment Variables**
   - ✅ Never commit `.env` file
   - ✅ Use platform's secret management
   - ✅ Rotate API keys regularly

2. **API Keys**
   - ✅ Users enter their own OpenAI API keys
   - ✅ Don't hardcode keys
   - ✅ Use environment variables

3. **Data Privacy**
   - ✅ No sensitive data in code
   - ✅ Resume data should be user-uploaded
   - ✅ Clear privacy policy

4. **Access Control**
   - ✅ Consider authentication for production
   - ✅ Rate limiting for API calls
   - ✅ Monitor usage

---

## 📝 Post-Deployment

### 1. Test Your Deployment
- [ ] App loads correctly
- [ ] File upload works
- [ ] API key validation works
- [ ] Queries return results
- [ ] Export functionality works

### 2. Monitor Performance
- [ ] Check response times
- [ ] Monitor API usage
- [ ] Track errors
- [ ] User feedback

### 3. Update Documentation
- [ ] Add deployment URL to README
- [ ] Update setup instructions
- [ ] Add troubleshooting section

---

## 🆘 Troubleshooting

### Common Issues:

1. **App won't start**
   - Check environment variables
   - Verify all dependencies installed
   - Check logs for errors

2. **Import errors**
   - Ensure all packages in requirements.txt
   - Check Python version (3.9+)

3. **Vector store not found**
   - Ensure vectorstore directory exists
   - Or run ingest_data.py first

4. **API key errors**
   - Verify OpenAI API key is valid
   - Check API key format

---

## 📊 Recommended Deployment

**For Portfolio/Resume**: **Streamlit Cloud** (Free, Easy, Fast)
- Best for showcasing your work
- No server management needed
- Automatic updates

**For Production**: **AWS/GCP/Azure** (Scalable, Reliable)
- Best for real-world use
- More control and customization
- Better performance

---

## 🔗 Quick Links

- **Streamlit Cloud**: https://streamlit.io/cloud
- **Heroku**: https://www.heroku.com/
- **AWS EC2**: https://aws.amazon.com/ec2/
- **Docker**: https://www.docker.com/

---

**Your app is ready to deploy! 🚀**

