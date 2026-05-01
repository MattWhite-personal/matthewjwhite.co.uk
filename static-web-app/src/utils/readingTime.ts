export interface ReadingTimeResult {
	minutes: number;
	words: number;
}

/**
 * Strip markdown and HTML syntax from text to get plain text
 */
function stripMarkdown(text: string): string {
	// Remove HTML tags (repeat until stable to avoid incomplete multi-character sanitization)
	let stripped = text;
	let previous: string;
	do {
		previous = stripped;
		stripped = stripped.replace(/<[^>]*>/g, '');
	} while (stripped !== previous);
	
	// Remove markdown links [text](url)
	stripped = stripped.replace(/\[([^\]]*)\]\([^)]*\)/g, '$1');
	
	// Remove markdown bold/italic
	stripped = stripped.replace(/[*_]{1,2}([^*_]+)[*_]{1,2}/g, '$1');
	
	// Remove markdown headers
	stripped = stripped.replace(/^#+\s+/gm, '');
	
	// Remove markdown code blocks
	stripped = stripped.replace(/```[\s\S]*?```/g, '');
	stripped = stripped.replace(/`([^`]+)`/g, '$1');
	
	// Remove extra whitespace
	stripped = stripped.replace(/\s+/g, ' ').trim();
	
	return stripped;
}

/**
 * Calculate reading time in minutes based on text content
 * @param text - The text to analyze
 * @param wordsPerMinute - Reading speed (default: 200 words per minute)
 * @returns Reading time result with minutes and word count
 */
export function calculateReadingTime(
	text: string,
	wordsPerMinute: number = 200
): ReadingTimeResult {
	const plainText = stripMarkdown(text);
	const words = plainText.split(/\s+/).filter(word => word.length > 0).length;
	const minutes = Math.ceil(words / wordsPerMinute);

	return {
		minutes: Math.max(1, minutes),
		words,
	};
}