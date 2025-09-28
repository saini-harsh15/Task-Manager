package com.task.taskmanager.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/**
 * Prevents browsers from caching authenticated pages so that after logout,
 * using the browser back button won't show protected content from cache.
 */
@Component
public class NoCacheFilter extends OncePerRequestFilter {

    private static final String[] PROTECTED_PREFIXES = new String[] {
            "/dashboard",
            "/tasks"
    };

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        String path = request.getRequestURI();
        if (isProtectedPath(request, path)) {
            addNoStoreHeaders(response);
        }
        filterChain.doFilter(request, response);
    }

    private boolean isProtectedPath(HttpServletRequest request, String path) {
        if (path == null) return false;
        String contextPath = request.getContextPath();
        if (contextPath != null && !contextPath.isEmpty() && path.startsWith(contextPath)) {
            path = path.substring(contextPath.length());
        }
        for (String prefix : PROTECTED_PREFIXES) {
            if (path.startsWith(prefix)) {
                return true;
            }
        }
        return false;
    }

    private void addNoStoreHeaders(HttpServletResponse response) {
        // HTTP 1.1
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        // HTTP 1.0
        response.setHeader("Pragma", "no-cache");
        // Proxies
        response.setDateHeader("Expires", 0);
    }
}
