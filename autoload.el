;;; ~/.doom.d/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +set-monospaced-font (english chinese english-size chinese-size)
  (set-face-attribute 'default nil :font
                      (format "%s:pixelsize=%d" english english-size))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family chinese :size chinese-size))))

;;;###autoload
(defadvice find-file (before make-directory-maybe
                             (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (when dir
        (unless (file-exists-p dir)
          (make-directory dir t))))))

;;;###autoload
(defun find-in-dotfiles ()
  "Open a file somewhere in ~/.dotfiles via a fuzzy filename search."
  (interactive)
  (doom-project-find-file (expand-file-name "~/.dotfiles")))

;;;###autoload
(defun browse-dotfiles ()
  "Browse the files in ~/.dotfiles."
  (interactive)
  (doom-project-browse (expand-file-name "~/.dotfiles")))

;;;###autoload
(defun update-dotfiles ()
  "Update the dotfiles to the latest version."
  (interactive)
  (let ((dir (or (getenv "DOTFILES")
                 (expand-file-name "~/.dotfiles/"))))
    (if (file-exists-p dir)
        (progn
          (message "Updating dotfiles...")
          (cd dir)
          (shell-command "git pull")
          (message "Updating dotfiles...done"))
      (message "\"%s\" doesn't exist" dir))))

;;;###autoload
(defun +switch-to-minibuffer-window ()
  "switch to minibuffer window (if active)"
  (interactive)
  (when (active-minibuffer-window)
    (select-window (active-minibuffer-window))))

;;;###autoload
(defun toggle-frame-transparency (&optional frame)
  "Toggle between transparent and opaque state for FRAME.
If FRAME is nil, it defaults to the selected frame."
  (interactive)
  (if (equal (frame-parameter frame 'alpha) 85)
      (set-frame-parameter frame 'alpha 100)
    (set-frame-parameter frame 'alpha 85)))

;; Network Proxy
;;;###autoload
(defun proxy-http-show ()
  "Show HTTP/HTTPS proxy."
  (interactive)
  (if url-proxy-services
      (message "Current HTTP proxy is `%s'" centaur-proxy)
    (message "No HTTP proxy")))

;;;###autoload
(defun proxy-http-enable ()
  "Enable HTTP/HTTPS proxy."
  (interactive)
  (setq url-proxy-services
        `(("http" . "127.0.0.1:7890")
          ("https" . "127.0.0.1:7890")
          ("no_proxy" . "^\\(localhost\\|127.0.0.1\\|192.168.*\\|172.16.*\\|10.0.*\\)")))
  (proxy-http-show))

;;;###autoload
(defun proxy-http-disable ()
  "Disable HTTP/HTTPS proxy."
  (interactive)
  (setq url-proxy-services nil)
  (proxy-http-show))

;;;###autoload
(defun proxy-http-toggle ()
  "Toggle HTTP/HTTPS proxy."
  (interactive)
  (if url-proxy-services
      (proxy-http-disable)
    (proxy-http-enable)))
