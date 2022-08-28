# Helper to parse twitter image
parse_twitter_pic <- function(){
  # TODO parse twitter path better
  path <- "https://pbs.twimg.com/profile_images/1541140792844193795/X9HNjfex_400x400.jpg"
  im <- magick::image_read(path)
  
  # get height, width and crop longer side to match shorter side
  ii <- magick::image_info(im)
  ii_min <- min(ii$width, ii$height)
  im1 <- magick::image_crop(im, geometry=paste0(ii_min, "x", ii_min, "+0+0"), repage=TRUE)
  
  # create a new image with white background and black circle
  fig <- magick::image_draw(magick::image_blank(ii_min, ii_min))
  symbols(ii_min/2, ii_min/2, circles=(ii_min/2)-3, bg='black', inches=FALSE, add=TRUE)
  invisible(dev.off())
  # create an image composite using both images
  im2 <- magick::image_composite(im1, fig, operator='copyopacity')
  
  # set background as white
  #magick::image_background(im2, 'white')
  return(im2)
} 