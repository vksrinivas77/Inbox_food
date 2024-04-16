<?php
// Define the root directory of your website
$root_directory = 'C:/xampp1/htdocs/INBOX';

// Function to recursively scan a directory for PHP files and extract URLs
function scan_directory_for_urls($dir) {
    // Initialize an empty array to store URLs
    $urls = array();
    
    // List the contents of the directory
    $files = scandir($dir);
    
    // Iterate over each item in the directory
    foreach ($files as $file) {
        // Skip special directories '.' and '..'
        if ($file != '.' && $file != '..') {
            // Construct the full path of the item
            $path = $dir . '/' . $file;
            // If the item is a directory, recursively scan it
            if (is_dir($path)) {
                // Recursively call the function to scan the subdirectory
                $sub_urls = scan_directory_for_urls($path);
                $urls = array_merge($urls, $sub_urls);
            } elseif (pathinfo($path, PATHINFO_EXTENSION) == 'php') {
                // If the item is a PHP file, extract URLs from it
                $urls = array_merge($urls, extract_urls_from_php_file($path));
            }
        }
    }
    
    // Return the list of URLs collected in this directory and its subdirectories
    return $urls;
}

// Function to extract URLs from a PHP file
function extract_urls_from_php_file($file_path) {
    // Read the content of the PHP file
    $file_content = file_get_contents($file_path);
    
    // Use regular expressions to find URLs in the content
    preg_match_all('/<a\s[^>]*?href=[\'"]([^\'"]+)[\'"]/i', $file_content, $matches);
    
    // Return the array of matched URLs
    return $matches[1];
}

// Call the function to scan the root directory for URLs
$urls = scan_directory_for_urls($root_directory);

// Generate sitemap XML
$xml = '<?xml version="1.0" encoding="UTF-8"?>';
$xml .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';
foreach ($urls as $url) {
    $xml .= '<url>';
    $xml .= '<loc>' . htmlspecialchars($url) . '</loc>';
    // Add additional tags like lastmod, changefreq, priority if needed
    $xml .= '</url>';
}
$xml .= '</urlset>';

// Write XML to sitemap.xml file
$file = fopen("sitemap.xml", "w");
fwrite($file, $xml);
fclose($file);

echo 'Sitemap generated successfully.';
?>
