(el-get-bundle git-gutter+)
(el-get-bundle git-gutter-fringe+
  (global-git-gutter+-mode t)
  (custom-set-faces
   '(git-gutter+-added ((t (:background "#8c9a43" :foreground "#8c9a43"))))
   '(git-gutter+-deleted ((t (:background "#d66556" :foreground "#d66556"))))
   '(git-gutter+-modified ((t (:background "#268bd2" :foreground "#268bd2"))))
   )
  )
