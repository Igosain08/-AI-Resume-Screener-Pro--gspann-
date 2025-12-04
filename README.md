# 🎯 AI Resume Screener Pro

**An Intelligent RAG-Powered Resume Screening System**

[![Python](https://img.shields.io/badge/Python-3.9+-blue.svg)](https://www.python.org/)
[![Streamlit](https://img.shields.io/badge/Streamlit-1.34.0-red.svg)](https://streamlit.io/)
[![LangChain](https://img.shields.io/badge/LangChain-0.1.17-green.svg)](https://www.langchain.com/)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

## 🌟 Overview

AI Resume Screener Pro is an advanced resume screening system that leverages **Retrieval-Augmented Generation (RAG)** technology to help hiring managers efficiently find the best candidates from thousands of resumes. Built with state-of-the-art AI models and semantic search, it provides intelligent candidate matching and analysis.

### ✨ Key Features

- **🤖 Intelligent RAG Pipeline**: Uses advanced RAG Fusion for superior candidate matching
- **⚡ Real-time Analysis**: Get instant insights on candidate fit and qualifications
- **📊 Analytics Dashboard**: View statistics, trends, and performance metrics
- **💾 Export Capabilities**: Download candidate lists and reports in JSON format
- **🎨 Modern UI**: Clean, professional interface designed for productivity
- **🔍 Multi-Model Support**: Works with GPT-4, GPT-3.5, GPT-4o-mini, and more
- **📈 Scalable**: Handles thousands of resumes efficiently
- **🔒 Privacy-Focused**: All processing happens in real-time, no permanent storage

## 🚀 Quick Start

### Prerequisites

- Python 3.9 or higher
- OpenAI API key ([Get one here](https://platform.openai.com/api-keys))
- 4GB+ RAM recommended

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd Resume-Screening-RAG-Pipeline
   ```

2. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Set up environment variables**
   
   Create a `.env` file in the root directory:
   ```env
   DATA_PATH=data/main-data/synthetic-resumes.csv
   FAISS_PATH=vectorstore
   EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2
   ```

4. **Run the application**
   ```bash
   streamlit run demo/interface.py
   ```

5. **Access the app**
   
   Open your browser to `http://localhost:8501`

## 📖 Usage Guide

### Basic Workflow

1. **Add API Key**: Enter your OpenAI API key in the sidebar
2. **Upload Resumes** (optional): Upload a CSV file with `ID` and `Resume` columns, or use the default dataset
3. **Enter Job Description**: Type a detailed job description in the chat
4. **Review Results**: Get AI-powered candidate recommendations with detailed analysis
5. **Export Results**: Download candidate lists for further analysis

### CSV Format

Your resume CSV file must contain exactly two columns:

| ID | Resume |
|----|--------|
| 0 | Full text of resume 1... |
| 1 | Full text of resume 2... |

### RAG Modes

- **Generic RAG**: Faster processing, ideal for simple queries
- **RAG Fusion**: Advanced multi-perspective querying for complex job descriptions (recommended)

### Supported Models

- `gpt-4o-mini` (recommended for cost-effectiveness)
- `gpt-4` (best quality)
- `gpt-4-turbo`
- `gpt-3.5-turbo`

## 🏗️ Architecture

### System Components

```
┌─────────────────┐
│  Streamlit UI   │
└────────┬────────┘
         │
┌────────▼────────┐
│  RAG Pipeline   │
├─────────────────┤
│ • Query Router  │
│ • RAG Fusion    │
│ • Retriever     │
└────────┬────────┘
         │
┌────────▼────────┐
│  FAISS Vector   │
│     Store       │
└────────┬────────┘
         │
┌────────▼────────┐
│  OpenAI GPT     │
│   Generator     │
└─────────────────┘
```

### Technology Stack

- **Frontend**: Streamlit with custom CSS
- **RAG Framework**: LangChain
- **Vector Database**: FAISS
- **Embeddings**: Sentence Transformers (HuggingFace)
- **LLM**: OpenAI GPT models
- **Data Processing**: Pandas, NumPy

## 🎨 Features in Detail

### 1. Smart Candidate Matching

The system uses semantic search to find candidates whose resumes best match your job description. RAG Fusion generates multiple query perspectives for better matching accuracy.

### 2. Real-time Analytics

- Total resumes in database
- Queries processed today
- Average response time
- Candidates found per query

### 3. Export Functionality

Download search results in JSON format including:
- Query details
- Matched candidates
- Timestamps
- Configuration used

### 4. Modern User Interface

- Gradient header design
- Real-time statistics dashboard
- Clean chat interface
- Responsive sidebar
- Professional color scheme

## 📊 Performance

- **Speed**: Processes queries in 2-5 seconds
- **Accuracy**: High precision candidate matching
- **Scalability**: Tested with 10,000+ resumes
- **Efficiency**: Optimized vector search with FAISS

## 🔧 Configuration

### Environment Variables

```env
DATA_PATH=path/to/resumes.csv
FAISS_PATH=path/to/vectorstore
EMBEDDING_MODEL=sentence-transformers/all-MiniLM-L6-v2
```

### Customization

- Modify `demo/interface.py` for UI changes
- Adjust RAG parameters in `demo/retriever.py`
- Change embedding model in `.env` file

## 📁 Project Structure

```
Resume-Screening-RAG-Pipeline/
├── demo/
│   ├── interface.py          # Main Streamlit app
│   ├── llm_agent.py          # LLM agent implementation
│   ├── retriever.py          # RAG retriever logic
│   ├── ingest_data.py        # Data ingestion script
│   └── chatbot_verbosity.py  # Chat display utilities
├── data/
│   ├── main-data/            # Resume datasets
│   └── supplementary-data/   # Additional data
├── vectorstore/              # FAISS vector database
├── requirements.txt          # Python dependencies
├── .env                      # Environment configuration
└── README.md                 # This file
```

## 🛠️ Development

### Adding New Features

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Running Tests

```bash
# Test data ingestion
python demo/interactive/ingest_data.py

# Test retriever
python demo/retriever.py
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [LangChain](https://www.langchain.com/) for RAG pipeline
- Uses [FAISS](https://github.com/facebookresearch/faiss) for efficient vector search
- Powered by [OpenAI](https://openai.com/) GPT models
- UI built with [Streamlit](https://streamlit.io/)

## 📧 Contact

For questions, issues, or contributions, please open an issue on GitHub.

---

**Made with ❤️ using RAG Technology**
