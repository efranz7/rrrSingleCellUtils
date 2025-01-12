% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scSeurat.R
\name{tenx_load_qc}
\alias{tenx_load_qc}
\title{Load 10X data}
\usage{
tenx_load_qc(
  path_10x,
  min_cells = 5,
  min_features = 800,
  mt_pattern = "^mt-|^MT-",
  species_pattern = "",
  remove_species_pattern = TRUE,
  violin_plot = TRUE,
  sample_name = path_10x
)
}
\arguments{
\item{path_10x}{Path to 10X RNAseq data "filtered_feature_bc_matrix" folder}

\item{min_cells}{Passed to CreateSeuratObject: Include features detected in
at least this many cells. Will subset the counts matrix as well. To
reintroduce excluded features, create a new object with a lower cutoff.}

\item{min_features}{Passed to CreateSeuratObject: Include cells where at
least this many features are detected.}

\item{mt_pattern}{Pattern used to identify mitochondrial reads (eg, "^MT-"
Must add species_pattern if remove_species_pattern = FALSE
(eg, "^hg19-MT-" or "^hg19-MT-|^mm10-mt-")}

\item{species_pattern}{Pattern used to select only reads from a single
species (eg, "^mm10-" or "^hg19-")}

\item{remove_species_pattern}{Specifies if want to remove species_pattern
prefix from gene names. If TRUE (default), removes species_pattern
prefix.}

\item{violin_plot}{If TRUE (default), produces a violin plot}

\item{sample_name}{Sample name. Used in violin plots for title}
}
\value{
A \code{\link{Seurat}}
}
\description{
Load 10X data
}
\examples{
\dontrun{
seurat_obj <- tenXLoadQC("path/to/10X/data/", species_pattern = "^mm9-")
}
}
