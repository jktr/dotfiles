;;; smart-tabs-mode.el

; https://github.com/jcsalomon/smarttabs/blob/master/smart-tabs-mode.el

;; (smart-tabs-add-language-support c++ c++-mode-hook
;;       ((c-indent-line . c-basic-offset)
;;        (c-indent-region . c-basic-offset)))

(smart-tabs-insinuate
 'c
 'c++
 'java
 'javascript
 'cperl
 'python
 'ruby
 'nxml
 )
