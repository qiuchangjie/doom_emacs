;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "ChangJie.Qiu"
      user-mail-address "qiuchangjie@foxmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;(setq doom-font (font-spec :family "Consolas" :size 21))
(setq doom-font (font-spec :family "Microsoft Yahei Mono" :size 16)
  doom-big-font (font-spec :family "Microsoft Yahei Mono" :size 26))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "~/org/")
(setq org-directory "H:/workspace/github/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)


(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(setq doom-interactive-mode nil)

;;设置闪屏
(setq fancy-splash-image (expand-file-name "banners/emacs.png" doom-emacs-dir))

;;增加的配置
;; windows查找文件
(after! projectile
  ;; ignore 好像没用
  ; (add-to-list 'projectile-globally-ignored-file-suffixes '(".meta" ".asset" ".unity" ".png" ".TGA" ".PSD" ".fbx"))
  ; ;;(add-to-list 'projectile-globally-ignored-directories '("tmp" "log" ".git" ".svn" "temp" "obj" "build" "Library" "StreamingAssets" "ProjectSettings" "ArtResources"))
  ; (add-to-list 'projectile-globally-ignored-directories "StreamingAssets")
  ; (add-to-list 'projectile-globally-ignored-directories "ProjectSettings")
  ; (add-to-list 'projectile-globally-ignored-directories "ArtResources")
  ; (add-to-list 'projectile-globally-ignored-directories "Plugins")
  ; (add-to-list 'projectile-globally-ignored-directories "Wwise")
  ; (add-to-list 'projectile-globally-ignored-directories "AddressableAssetsData")
  ; (add-to-list 'projectile-globally-ignored-directories "_TerrainAutoUpgrade")

  (setq projectile-generic-command
        (mapconcat #'shell-quote-argument
                   (append (list "rg" "-0" "--files" "--follow" "--color=never" "--hidden")
                           (cl-loop for dir in projectile-globally-ignored-directories
                                    collect "--glob"
                                    collect (concat "!" dir))
                           )
                   " ")
        projectile-git-command projectile-generic-command)
  )

;(custom-set-variables '(company-lua-executable (executable-find "lua53")))

(after! lua
  (setq lua-indent-level 4)
  )

;; 解决 gnutls.el: (err=[-50] The request is invalid.) 报错
(setq gnutls-algorithm-priority nil)
; (setq gnutls-min-prime-bits nil)
; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.2")


;;程序.emacs.d目录下
;;Add these packages to your load-path
;;And now they can be loaded with require or def-package!/use-package.
(let ((default-directory (expand-file-name "private-packages" doom-emacs-dir)))
  (normal-top-level-add-subdirs-to-load-path))
;; 加载十字光标
(use-package crosshairs)


;; 去掉^M换行符
(setq projectile-svn-command "svn list -R . | grep -v '$/' | tr '\\n' '\\0' | tr -d '\\r'")
(setq projectile-git-command "git ls-files -zco --exclude-standard | tr -d '\\r'")

;; UTF-8作为默认编码方式
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;;(set-selection-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")

;; File Operation
(setq tab-width 4
      inhibit-splash-screen t
      initial-scratch-message nil
      sentence-end-double-space nil
      make-backup-files nil
      indent-tabs-mode nil
      make-backup-files nil
      auto-save-default nil)
(setq create-lockfiles nil)

(setq inhibit-compacting-font-caches t) ; Don’t compact font caches during GC.

;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
;; Sample jar configuration
(setq plantuml-jar-path "D:/Software/doom-emacs-26.3/.emacs.d/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)
;; active org-babel languages
(org-babel-do-load-languages
  'org-babel-load-languages '(;; other babel languages
    (plantuml . t)))
(setq org-plantuml-jar-path (expand-file-name "D:/Software/doom-emacs-26.3/.emacs.d/plantuml.jar"))
;; Integration with org-mode
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

;; omnisharp config
(after! omnisharp (setq omnisharp-server-executable-path "D:/Software/doom-emacs-26.3/.emacs.d/.local/etc/omnisharp/server/v1.34.5/OmniSharp.exe"))
;;(setq omnisharp-server-executable-path "D:/Software/emacs-26.3-x86_64/omnisharp-win-x86/OmniSharp.exe")

(defun omnisharp-kbd-setup ()
  (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
  )
(add-hook 'csharp-mode-hook 'omnisharp-kbd-setup t)

;;  ### begin  自动启动omnisharp server
;;  自己实现向上查找工程文件
(defun find-vs-solution-upwards (dirname)
  "Recursively find first VS solution file from this directory upwards."
  (unless (or (string-empty-p dirname) (string-equal dirname "/"))
    (let ((slns (directory-files dirname 't "\\.sln$")))
      (if slns
          (car slns)
        (find-vs-solution-upwards (expand-file-name (concat (file-name-as-directory dirname) "..")))))))

(defun omnisharp-server-running? ()
  "Non-nil if there is a buffer called \"OmniServer\""
  (get-buffer "OmniServer"))

(defun maybe-start-omnisharp ()
  "Does what it says."
  (interactive)
  (unless (omnisharp-server-running?)

    (let* ((slns (find-vs-solution-upwards (file-name-directory (buffer-file-name)))))
      ;(message "print test: ")
      ;(message slns)
      ;(message (file-name-directory slns))
      (require 'omnisharp)
      (require 'omnisharp-server-management)
      ;; 该函数可以指定工程根目录启动omnisharp-server
      (omnisharp--do-server-start (file-name-directory slns))
      )
    ;; 这个函数内部自动获取了工程根目录，不准确
    ;(omnisharp-start-omnisharp-server (find-vs-solution-upwards (file-name-directory (buffer-file-name))))
    )
  )


(add-hook 'csharp-mode-hook 'omnisharp-mode)
(add-hook 'csharp-mode-hook 'maybe-start-omnisharp)
;;  ### end

;; config company
(setq company-idle-delay 0)

(setq +pretty-code-enabled-modes nil)

(add-to-list 'auto-mode-alist '("\\.cginc$" . shader-mode))

;; remove ^M
(defun delete-carrage-returns ()
  (interactive)
  (save-excursion
    (goto-char 0)
    (while (search-forward "\r" nil :noerror)
      (replace-match ""))))

;; 太长的文件关闭linum-mode提升效率
(defun buffer-too-big-p ()
  (or (> (buffer-size) (* 500 64))
      (> (line-number-at-pos (point-max)) 500)))

(defun generic-setup ()
  ;; turn off 'linum-mode' when there are more than 800 lines
  (if (buffer-too-big-p) (linum-mode -1)))
(add-hook 'prog-mode-hook 'generic-setup)
(add-hook 'text-mode-hook 'generic-setup)

(setq font-lock-verbose nil) ; to avoid the annoying messages
(setq lazy-lock-continuity-time 0.3) ; refontify after 0.3 inactivity

(if (not (display-graphic-p))
    (progn
      ;; 增大垃圾回收的阈值，提高整体性能（内存换效率）
      (setq gc-cons-threshold (* 8192 8192))
      ;; 增大同LSP服务器交互时的读取文件的大小
      (setq read-process-output-max (* 1024 1024 128)) ;; 128MB
      ))

;; better performance on everything (especially windows), ivy-0.10.0 required
;; @see https://github.com/abo-abo/swiper/issues/1218
;; 延时的目的是当用户停止输入0.25秒后再启动进程。这样减少了多个进程调用的开销。在Windows下进程调用开销比较大，此技术可以改善UI体验
(setq ivy-dynamic-exhibit-delay-ms 250)

;; 设置中文字体
(set-fontset-font t 'han (font-spec :family "Microsoft YaHei" :size 16))
;; 解决 doom-emacs 设置中文字体后屏幕中出现大量中文时，移动光标都卡
(setq doom-unicode-extra-fonts nil)
