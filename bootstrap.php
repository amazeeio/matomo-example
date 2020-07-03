<?php
/**
 * Lagoon
 *
 * @link https://lagoon.sh
 *
 * This file defines boostrap functions for running Matomo on Lagoon
 *
 */

// Define PIWIK_USER_PATH with our persistent mounted folder.
// This ensures that the matomo config is kept during container restarts.
define('PIWIK_USER_PATH', '/persistent');