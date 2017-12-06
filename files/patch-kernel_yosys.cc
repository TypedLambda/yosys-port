--- kernel/yosys.cc.orig	2017-12-06 15:19:54 UTC
+++ kernel/yosys.cc
@@ -45,6 +45,10 @@
 #  include <sys/stat.h>
 #  include <glob.h>
 #endif
+#ifdef __FreeBSD__
+#include <wait.h>
+#include <sys/sysctl.h>
+#endif
 
 #include <limits.h>
 #include <errno.h>
@@ -698,6 +702,24 @@ std::string proc_self_dirname()
 std::string proc_self_dirname()
 {
 	return "/";
+}
+#elif defined(__FreeBSD__)
+std::string proc_self_dirname()
+{    
+	int  mib[4];
+	size_t len;
+	char buf[PATH_MAX+1];
+	len=sizeof(buf);
+
+	mib[0] = CTL_KERN;
+	mib[1] = KERN_PROC;
+	mib[2] = KERN_PROC_PATHNAME;
+	mib[3] = -1;
+
+	if (sysctl(mib, 4, &buf, &len, NULL, 0) == -1)
+		return "";
+	else
+		return std::string(buf, len);
 }
 #else
 	#error Dont know how to determine process executable base path!
