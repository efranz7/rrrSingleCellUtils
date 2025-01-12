#' Color scheme to use for plots
#'
#' @name plot_cols
#' @format vector of color hex values
#' @keywords data
#' @export
plot_cols <- c("#D43F3AFF", "#EEA236FF", "#357EBDFF", "#5CB85CFF",
               "#B8B8B8FF", "#9632B8FF", "#46B8DAFF", "#90302DFF",
               "#A66D04FF", "#2D577FFF", "#3E7E3EFF", "#7D7D7DFF",
               "#6D1D87FF", "#097F9AFF", "#FF6E6AFF", "#FFBB70FF",
               "#68A4E3FF", "#79D379FF", "#CDCDCDFF", "#BF6BE2FF",
               "#69D1F3FF")

#' Roberts lab Seurat::DimPlot default changes
#'
#' @inheritParams Seurat::DimPlot
#' @param title Title to use for plot
#' @param ... Other arguments to pass to Seurat::DimPlot
#'
#' @return A patchworked ggplot object if combine = TRUE; otherwise, a list of
#' ggplot objects
#' @export
#'
#' @examples
#' \dontrun{
#' cid_lt <- gen_cellecta_bc_data(file = "path/to/file.bam",
#'                                verbose = TRUE,
#'                                samtools_module = "GCC/9.3.0 SAMtools/1.10")
#' output <- process_ltbc(sobject, cid_lt = cid_lt, histogram = TRUE)
#' }
r_dim_plot <- function(object,
                       title = NULL,
                       label = TRUE,
                       pt.size = 1,
                       ...) {
    if(length(levels(Seurat::Idents(object))) < 22) {
        p <- Seurat::DimPlot(object = object,
                             label = label,
                             pt.size = pt.size,
                             cols = scales::alpha(plot_cols, 0.6),
                             ...) +
            patchwork::plot_annotation(title = title) +
            ggplot2::theme(legend.position = "none") +
            ggplot2::coord_fixed()
        return(p)
    } else {
        print("Too many identity classes to use this function. Requires <22.")
    }
}


#' Roberts lab Seurat::FeaturePlot default changes
#'
#' @inheritParams Seurat::FeaturePlot
#' @param title Title to use for plot
#' @param ... Other arguments to pass to Seurat::FeaturePlot
#'
#' @return A patchworked ggplot object if combine = TRUE; otherwise, a list
#' of ggplot objects
#' @export
#'
#' @examples
#' \dontrun{
#' Seurat::FeaturePlot(object = sobject)
#' }
r_feature_plot <- function(object,
                           features,
                           title = NULL,
                           pt.size = 1,
                           order = TRUE,
                           ...) {
    p <- Seurat::FeaturePlot(object = object,
                             features = features,
                             pt.size = pt.size,
                             order = order,
                             cols = (c("lightgoldenrod", "darkred")),
                             ...) +
        patchwork::plot_annotation(title = title) +
        ggplot2::coord_fixed()
    return(p)
}

#' Roberts lab ggplot theme defaults
#'
#' @param axis_font_size Font size for axis text
#' @param axis_title_font_size Font size for axis titles
#' @param facet_font_size Font size for facet titles
#' @param font_name Name of font to use
#' @param legend_key_size Spacing of legend items (in cm)
#' @param legend_text_font_size Font size for legend text
#' @param legend_title_font_size Font size for legend title
#' @param subtitle_font_size Font size for subtitle
#' @param title_font_size Font size for title
#'
#' @return A list object to use as a theme
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' }
theme_roberts <- function(axis_font_size = 5,
                          axis_title_font_size = 8,
                          facet_font_size = 5,
                          font_name = "Arial",
                          legend_key_size = "0.2",
                          legend_text_font_size = 5,
                          legend_title_font_size = 6,
                          subtitle_font_size = 6,
                          title_font_size = 10) {
    if (font_name == "Arial" &
        !"Arial" %in% names(grDevices::pdfFonts())) {
        #    !"Arial" %in% sysfonts::font_families()) {
        message("Adding Arial font to system")
        tryCatch(
            {
                extrafont::font_import(paths = "/home/gdrobertslab/lab/Tools/fonts/Arial/",
                                       prompt = FALSE)
                extrafont::loadfonts(quiet = TRUE)
            },
                error = function(e) {
                    message("Arial font files not found in /home/gdrobertslab/lab/Tools/fonts/Arial/")
                    message("Either use a different font or install Arial")
                    print(e)
                    stop()
            }
        )
    }
    list(ggpubr::theme_pubr(base_family = font_name) +
         ggplot2::theme(
            axis.text = ggplot2::element_text(size = axis_font_size),
            axis.title = ggplot2::element_text(size = axis_title_font_size),
            plot.title = ggplot2::element_text(size = title_font_size,
                                               face = "bold",
                                               hjust = 0.5),
            strip.text = ggplot2::element_text(size = facet_font_size,
                                               face = "bold"),
            plot.subtitle = ggplot2::element_text(hjust = 0.5,
                                                  size = subtitle_font_size),
            legend.text = ggplot2::element_text(size = legend_text_font_size),
            legend.title = ggplot2::element_text(size = legend_title_font_size,
                                                 face = "bold"),
            strip.background = ggplot2::element_blank(),
            legend.key.size = ggplot2::unit(0.2, "cm")
            ),
    ggplot2::scale_color_manual(values = plot_cols))
}
