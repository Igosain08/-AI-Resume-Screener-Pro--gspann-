# How to Input Resumes into the System

There are **two ways** to add resumes to the Resume Screening RAG Pipeline:

## Method 1: Upload via Streamlit UI (Temporary - Session Only)

### Steps:
1. **Open the Streamlit app** at http://localhost:8502
2. **Look at the sidebar** on the left
3. **Find the "Upload resumes" section**
4. **Click "Browse files"** and select your CSV file
5. **Wait for indexing** - The system will process and index your resumes (this may take a few minutes)

### CSV Format Required:
Your CSV file **must** have exactly these two columns:

| ID | Resume |
|----|--------|
| 0 | Full text of resume 1 here... |
| 1 | Full text of resume 2 here... |
| 2 | Full text of resume 3 here... |

**Important Notes:**
- ✅ Column names must be exactly: `ID` and `Resume` (case-sensitive)
- ✅ `ID` should be unique for each resume (can be numbers or strings)
- ✅ `Resume` column contains the full text content of each resume
- ⚠️ **This is temporary** - Uploaded data is only available during your current session. If you refresh the page, it reverts to the default resumes.

---

## Method 2: Add Resumes Permanently (Recommended)

### Option A: Replace the Default CSV File

1. **Prepare your CSV file** with the format shown above
2. **Save it** as `synthetic-resumes.csv`
3. **Replace the file** at: `data/main-data/synthetic-resumes.csv`
4. **Re-index the vectorstore** (see below)

### Option B: Add to Existing Resumes

1. **Open** `data/main-data/synthetic-resumes.csv`
2. **Add your new resumes** to the file (keep existing ones or remove them)
3. **Re-index the vectorstore** (see below)

### Re-indexing After Adding Resumes:

After modifying the CSV file, you need to rebuild the vector database:

```bash
cd Resume-Screening-RAG-Pipeline
python demo/interactive/ingest_data.py
```

Or use the ingest script directly:
```bash
cd demo
python ingest_data.py
```

**Note:** This will create/update the vectorstore in the `vectorstore/` directory.

---

## CSV File Example

Here's a sample CSV file structure:

```csv
ID,Resume
0,"John Doe
Software Engineer with 5 years of experience in Python and JavaScript.
Skills: React, Node.js, PostgreSQL, AWS
Education: BS Computer Science, MIT 2018"
1,"Jane Smith
Data Scientist specializing in machine learning and NLP.
Experience: 3 years at Google, 2 years at startup
Skills: Python, TensorFlow, PyTorch, SQL
Education: MS Data Science, Stanford 2019"
2,"Bob Johnson
Full-stack developer with expertise in cloud architecture.
Experience: 7 years building scalable web applications
Skills: Java, Spring Boot, Docker, Kubernetes, Azure
Education: BS Software Engineering, UC Berkeley 2015"
```

---

## Converting PDF Resumes to CSV

If you have PDF resumes, you can use the provided conversion script:

```bash
cd demo/interactive
python convert_pdf.py
```

Or manually:
1. Extract text from PDFs
2. Create a CSV with `ID` and `Resume` columns
3. Put each resume's full text in the `Resume` column

---

## Tips for Best Results

1. **Resume Content Quality:**
   - Include full resume text (not just summaries)
   - Keep formatting clean (remove special characters if needed)
   - Include skills, experience, education, etc.

2. **ID Format:**
   - Use simple IDs: 0, 1, 2, 3... or "resume-1", "resume-2"
   - Make sure each ID is unique

3. **File Size:**
   - Large files (1000+ resumes) will take longer to index
   - Consider batching if you have many resumes

4. **Testing:**
   - Start with a small CSV (5-10 resumes) to test
   - Verify it works before adding hundreds of resumes

---

## Current Default Data

The system comes with:
- **Synthetic resumes**: `data/main-data/synthetic-resumes.csv`
- **Pre-built vectorstore**: `vectorstore/` directory
- **Example job descriptions**: `data/supplementary-data/job_title_des.csv`

You can use these as templates or replace them with your own data.

---

## Troubleshooting

### Error: "Please include the following columns: Resume, ID"
- ✅ Check that your CSV has exactly these column names (case-sensitive)
- ✅ Make sure there are no extra spaces in column names

### Error: "File upload failed"
- ✅ Ensure your file is a valid CSV
- ✅ Check that the file isn't corrupted
- ✅ Try opening it in Excel/Google Sheets first to verify format

### Indexing takes too long
- ✅ This is normal for large files (100+ resumes)
- ✅ Be patient - it processes each resume and creates embeddings
- ✅ For permanent addition, use Method 2 and let it run in background

### Resumes not showing up after upload
- ✅ Check that indexing completed successfully
- ✅ Try refreshing the page
- ✅ Verify your CSV format is correct

---

## Quick Start Example

1. Create a file `my_resumes.csv`:
```csv
ID,Resume
0,"Software Engineer with Python experience..."
1,"Data Scientist with ML expertise..."
```

2. **Via UI**: Upload through Streamlit sidebar
   OR
   **Permanently**: Replace `data/main-data/synthetic-resumes.csv` and run:
   ```bash
   python demo/interactive/ingest_data.py
   ```

3. Restart Streamlit app if you did permanent method:
   ```bash
   streamlit run demo/interface.py
   ```

4. Start querying with job descriptions!

