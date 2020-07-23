;; -*- no-byte-compile: t; -*-
;;; my/translate/packages.el

(package! youdao-dictionary :pin "bd839711e3cf6d3eb9c308cea5694369a440899e")

(when (featurep! +childframe)
  (package! posframe :pin "922e4d239f7a083213d856de67a9686a091b1e27"))

(when (featurep! :completion company)
  (package! company-english-helper
    :recipe (:host github :repo "cxb811201/company-english-helper")
    :pin "242bd431f7f25a15f033b5e441ec90624acd59cc"))

(package! insert-translated-name
  :recipe (:host github :repo "manateelazycat/insert-translated-name")
  :pin "a11b8f565006ca99995021ba70084e386dc2f0f5")
