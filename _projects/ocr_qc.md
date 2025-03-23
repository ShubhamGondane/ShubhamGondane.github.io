---
layout: page
title: Automated OCR QC System
description: Building a Robust OCR Quality Control System for Scanned Drilling Reports in Python.
importance: 1
category: sideproject
related_publications: false
---

## Introduction

Optical Character Recognition (OCR) is powerful but imperfect. In this article, I'll walk through how we built a comprehensive quality control system for OCR output that helps identify potential issues and determines when manual review is needed.

## System Overview

The OCR QC system performs multiple levels of validation:

- Document-level JSON validation
- Page-level content analysis
- Table structure verification
- Spatial consistency checks

### Project Structure

```
OCR_QC/
├── ocr_qc_main.py          # Main entry point
├── ocr_qc_core.py          # Core validation functions
├── ocr_qc_content.py       # Content analysis functions
├── ocr_qc_structure.py     # Document structure checks
├── ocr_qc_spatial.py       # Spatial consistency validation
└── requirements.txt        # Project dependencies
```

## Core Components

### JSON Validation

The first step is validating the OCR output JSON:

```
qc_results['document_is_valid_json'] = is_valid_json(json_data)
if json_schema:
    schema_errors = validate_json_schema(json_data, json_schema)
    qc_results['document_json_schema_validation'] = str(schema_errors) if schema_errors else "Schema Valid"
```

This ensures the OCR output follows our expected structure before deeper analysis.

### Content Quality Metrics

For each page, we analyze several content quality indicators:

- Lexicon Word Ratio: Percentage of words found in a standard dictionary
- Stop Word Ratio: Frequency of common words like "the", "and", "in"
- Character-Level Checks: Detection of unusual or placeholder characters
- Confidence Scores: OCR engine's confidence in its text recognition

```
if page_text_content:
    lexicon_word_ratio, incoherent = calculate_lexicon_word_ratio(page_text_content)
    page_qc_results['lexicon_word_ratio'] = lexicon_word_ratio
    page_qc_results['stop_word_ratio'] = calculate_stop_word_ratio(page_text_content)
    page_qc_results['misspelled_word_detection'] = check_misspelled_words(page_text_content)
```

### Table Analysis

The system performs specialized checks for tabular content:

- Table structure validation (rows/columns)
- Cell content quality assessment
- Confidence metrics specific to table cells

```
for table_index, table_data in enumerate(document_tables_data):
    table_cell_contents = [cell.get('content', '') for cell in table_data.get('cells', [])]
    if table_cell_contents:
        table_qc_results = {}
        table_qc_results['dictionary_word_ratio'], table_qc_results['potential_text_incoherence'] = calculate_lexicon_word_ratio(table_cell_contents)
        # ... additional table checks
```

### Output and Reporting

Results are saved in two formats:

- Detailed JSON reports containing all metrics
- Plain text review logs for files requiring manual attention

```
review_needed, review_reasons = needs_manual_review(qc_results)
if review_needed:
    with open(output_review_filepath, 'a', encoding='utf-8') as review_file:
        for reason_category, reason_message in review_reasons.items():
            review_file.write(f"- {reason_category}: {reason_message}\n")
```

## Key Features

- Modular Design: Each quality check is a separate function, making the system easy to extend
- Configurable: JSON schema and entity patterns can be customized
- Batch Processing: Can process multiple files with progress tracking
- Detailed Reporting: Comprehensive metrics at document, page, and table levels

## Future Improvements

- Improve spatial order consistency checks (currently skipped due to low accuracy)
- Add numeric coherence validation
- Enhance formatting irregularity detection
- Add support for more document types and OCR engines

## Conclusion

This OCR QC system provides a robust framework for validating OCR output and identifying potential issues requiring human review. By combining multiple validation strategies at different levels, it helps ensure OCR accuracy while minimizing the need for manual intervention.

The complete code is organized into several Python modules, making it easy to maintain and extend. The system can be integrated into larger document processing pipelines or used as a standalone quality control tool.
