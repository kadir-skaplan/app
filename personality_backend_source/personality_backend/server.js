require('dotenv').config();
const express = require('express');
const cors = require('cors');
const axios = require('axios');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// AI Response Templates
const aiResponses = {
  'The Leader': {
    'first_message': [
      'Option 1: "Hey, I\'ve been impressed by your ambition. Would love to grab coffee and hear about your latest projects."',
      'Option 2: "I admire people who know what they want. What\'s your next big goal?"',
      'Option 3: "Your energy is magnetic. Let\'s connect over something meaningful."'
    ],
    'next_message': [
      'Option 1: "Tell me more about what drives you. I\'m genuinely interested."',
      'Option 2: "What\'s the biggest challenge you\'re facing right now?"',
      'Option 3: "I respect your vision. How can I support your journey?"'
    ],
    'why_distant': [
      'Leaders often pull back when they sense neediness or lack of ambition.',
      'They might be focused on a big project. Give them space.',
      'They respect independence. Show that you have your own goals.'
    ],
    'how_to_attract': [
      'Be confident and have your own ambitions.',
      'Show genuine interest in their goals.',
      'Challenge them intellectually.',
      'Respect their time and independence.'
    ]
  },
  'The Creative': {
    'first_message': [
      'Option 1: "Your creativity is captivating. I\'d love to explore your world."',
      'Option 2: "What\'s the most inspiring thing you\'ve created lately?"',
      'Option 3: "I see the artist in you. Let\'s create something together."'
    ],
    'next_message': [
      'Option 1: "Tell me about your creative process."',
      'Option 2: "What inspires you the most?"',
      'Option 3: "I\'d love to support your artistic journey."'
    ],
    'why_distant': [
      'Creatives need authenticity. Avoid superficial conversations.',
      'They might be in a creative flow. Don\'t interrupt their process.',
      'They value emotional connection. Show your true self.'
    ],
    'how_to_attract': [
      'Be authentic and genuine.',
      'Show interest in their creative work.',
      'Support their artistic vision.',
      'Create meaningful experiences together.'
    ]
  },
  'The Protector': {
    'first_message': [
      'Option 1: "I appreciate reliability. You seem like someone I can trust."',
      'Option 2: "Your loyalty is admirable. I\'d like to know you better."',
      'Option 3: "There\'s something solid about you. Can we talk?"'
    ],
    'next_message': [
      'Option 1: "What matters most to you in relationships?"',
      'Option 2: "I value your honesty. Tell me what you\'re thinking."',
      'Option 3: "I want to build something real with you."'
    ],
    'why_distant': [
      'Protectors need trust. Any sign of dishonesty will push them away.',
      'They might be protecting their heart. Be patient and consistent.',
      'Show that you\'re reliable and loyal.'
    ],
    'how_to_attract': [
      'Be honest and dependable.',
      'Show loyalty and commitment.',
      'Be patient with their protective nature.',
      'Build trust through consistent actions.'
    ]
  },
  'The Intellectual': {
    'first_message': [
      'Option 1: "I\'ve been thinking about [interesting topic]. What\'s your take?"',
      'Option 2: "Your mind is fascinating. Let\'s have a real conversation."',
      'Option 3: "I\'d love to explore ideas with someone as thoughtful as you."'
    ],
    'next_message': [
      'Option 1: "That\'s an interesting perspective. Tell me more."',
      'Option 2: "How did you come to that conclusion?"',
      'Option 3: "Let\'s dive deeper into this topic."'
    ],
    'why_distant': [
      'Intellectuals lose interest in shallow conversations.',
      'They need mental stimulation. Challenge their ideas respectfully.',
      'Show that you\'re equally thoughtful and curious.'
    ],
    'how_to_attract': [
      'Engage them in meaningful conversations.',
      'Ask thoughtful questions.',
      'Share interesting ideas and perspectives.',
      'Challenge them intellectually.'
    ]
  },
  'The Adventurer': {
    'first_message': [
      'Option 1: "Life\'s too short for boring. Want to do something spontaneous?"',
      'Option 2: "I sense your adventurous spirit. Let\'s explore together."',
      'Option 3: "You seem like someone who lives fully. I\'m intrigued."'
    ],
    'next_message': [
      'Option 1: "What\'s the craziest thing you\'ve done?"',
      'Option 2: "Let\'s plan an adventure together."',
      'Option 3: "Tell me about your next big trip."'
    ],
    'why_distant': [
      'Adventurers hate boredom and predictability.',
      'They need freedom. Don\'t try to cage them.',
      'Keep things exciting and spontaneous.'
    ],
    'how_to_attract': [
      'Be spontaneous and exciting.',
      'Share their love of adventure.',
      'Respect their need for freedom.',
      'Plan unexpected experiences together.'
    ]
  },
  'The Romantic': {
    'first_message': [
      'Option 1: "There\'s something special about you. I\'d like to explore this."',
      'Option 2: "I believe in meaningful connections. Can we try?"',
      'Option 3: "You make me believe in magic. Let\'s see where this goes."'
    ],
    'next_message': [
      'Option 1: "I\'m thinking about you. How are you feeling?"',
      'Option 2: "What does love mean to you?"',
      'Option 3: "I want to build something beautiful with you."'
    ],
    'why_distant': [
      'Romantics need emotional connection. Show your feelings.',
      'They might be protecting their heart. Be patient and genuine.',
      'Express your emotions openly and honestly.'
    ],
    'how_to_attract': [
      'Be emotionally open and vulnerable.',
      'Express your feelings clearly.',
      'Plan romantic gestures.',
      'Show that you believe in meaningful love.'
    ]
  }
};

// Routes
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', message: 'Server is running' });
});

app.post('/api/chat', (req, res) => {
  try {
    const { message, personalityType } = req.body;

    if (!message || !personalityType) {
      return res.status(400).json({
        error: 'Missing required fields',
      });
    }

    // Determine response category based on message
    let category = 'next_message';
    if (message.toLowerCase().includes('first')) {
      category = 'first_message';
    } else if (message.toLowerCase().includes('distant')) {
      category = 'why_distant';
    } else if (message.toLowerCase().includes('attract')) {
      category = 'how_to_attract';
    }

    // Get responses for personality type
    const responses =
      aiResponses[personalityType] || aiResponses['The Leader'];
    const categoryResponses = responses[category] || responses['next_message'];

    // Select a random response
    const selectedResponse =
      categoryResponses[
        Math.floor(Math.random() * categoryResponses.length)
      ];

    res.json({
      response: selectedResponse,
      personalityType: personalityType,
      category: category,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    console.error('Chat error:', error);
    res.status(500).json({
      error: 'Failed to process chat message',
      details: error.message,
    });
  }
});

app.post('/api/optimize', (req, res) => {
  try {
    const { message, personalityType } = req.body;

    if (!message || !personalityType) {
      return res.status(400).json({
        error: 'Missing required fields',
      });
    }

    // Simulate message optimization
    const optimizations = [
      `${message} (This shows genuine interest)`,
      `${message} (Keep it authentic and personal)`,
      `${message} (This respects their personality)`,
    ];

    const selected =
      optimizations[Math.floor(Math.random() * optimizations.length)];

    res.json({
      originalMessage: message,
      optimizedMessage: selected,
      suggestions: [
        'Keep it short and genuine',
        'Show authentic interest',
        'Respect their personality type',
      ],
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    console.error('Optimize error:', error);
    res.status(500).json({
      error: 'Failed to optimize message',
      details: error.message,
    });
  }
});

app.get('/api/premium/:userId', (req, res) => {
  try {
    const { userId } = req.params;

    // Simulate premium status check
    res.json({
      userId: userId,
      isPremium: false,
      expiresAt: null,
      features: ['chat', 'videos', 'premium_content'],
    });
  } catch (error) {
    console.error('Premium check error:', error);
    res.status(500).json({
      error: 'Failed to check premium status',
      details: error.message,
    });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({
    error: 'Internal server error',
    details: err.message,
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Not found',
    path: req.path,
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Personality App Backend running on port ${PORT}`);
  console.log(`📍 API Base: http://localhost:${PORT}`);
  console.log(`🔗 Health Check: http://localhost:${PORT}/api/health`);
});

module.exports = app;
