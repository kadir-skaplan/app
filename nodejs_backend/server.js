require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const axios = require('axios');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Load data
const data = JSON.parse(fs.readFileSync(path.join(__dirname, 'data.json'), 'utf8'));

// Helper: Get personality key from month and gender
function getPersonalityKey(month, gender) {
  const months = ['january', 'february', 'march', 'april', 'may', 'june', 
                  'july', 'august', 'september', 'october', 'november', 'december'];
  const monthIndex = Math.min(parseInt(month) - 1, 11); // 0-11
  const monthName = months[monthIndex];
  return `${monthName}_${gender.toLowerCase()}`;
}

// POST /analyze - Get personality analysis
app.post('/analyze', (req, res) => {
  try {
    const { day, month, gender } = req.body;
    
    if (!day || !month || !gender) {
      return res.status(400).json({ error: 'Missing required fields' });
    }
    
    const key = getPersonalityKey(month, gender);
    const personality = data.personalities[key] || data.personalities['january_male'];
    
    res.json({
      success: true,
      personality: {
        ...personality,
        key: key
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// POST /chat - AI chat endpoint
app.post('/chat', async (req, res) => {
  try {
    const { message, personalityType, topics, turnOff, lastMessage } = req.body;
    
    if (!message) {
      return res.status(400).json({ error: 'Message required' });
    }
    
    // Get appropriate prompt
    let prompt = '';
    if (message.includes('first message')) {
      prompt = data.ai_prompts.first_message
        .replace('{personality_type}', personalityType || 'this type')
        .replace('{topics}', topics?.join(', ') || 'their interests');
    } else if (message.includes('next') || message.includes('say')) {
      prompt = data.ai_prompts.next_reply
        .replace('{last_message}', lastMessage || 'their last message')
        .replace('{personality_type}', personalityType || 'this type')
        .replace('{turn_off}', turnOff || 'their turn-offs');
    } else if (message.includes('distant') || message.includes('why')) {
      prompt = data.ai_prompts.distance_reason
        .replace('{personality_type}', personalityType || 'this type');
    } else if (message.includes('attract') || message.includes('how to')) {
      prompt = data.ai_prompts.attraction_tips
        .replace('{personality_type}', personalityType || 'this type');
    } else {
      prompt = `Provide 3 short, actionable response options for someone dealing with a ${personalityType || 'this personality type'}. User asks: "${message}". Format each option clearly.`;
    }
    
    // Call OpenAI API (or use mock if no key)
    let aiResponse;
    
    if (process.env.OPENAI_API_KEY && process.env.OPENAI_API_KEY !== 'your_api_key_here') {
      const response = await axios.post(
        'https://api.openai.com/v1/chat/completions',
        {
          model: 'gpt-3.5-turbo',
          messages: [
            { role: 'system', content: 'You are a dating and relationship expert. Provide short, actionable advice in an emotionally engaging tone. Always give 3 specific options.' },
            { role: 'user', content: prompt }
          ],
          max_tokens: 300,
          temperature: 0.7
        },
        {
          headers: {
            'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
            'Content-Type': 'application/json'
          }
        }
      );
      aiResponse = response.data.choices[0].message.content;
    } else {
      // Mock response for demo
      aiResponse = generateMockResponse(message, personalityType);
    }
    
    res.json({
      success: true,
      response: aiResponse,
      options: parseOptions(aiResponse)
    });
  } catch (error) {
    console.error('Chat error:', error.message);
    res.status(500).json({ error: 'Failed to get AI response' });
  }
});

// POST /optimize - Optimize a message
app.post('/optimize', async (req, res) => {
  try {
    const { originalMessage, personalityType, goal } = req.body;
    
    if (!originalMessage) {
      return res.status(400).json({ error: 'Original message required' });
    }
    
    let prompt = `Optimize this message for a ${personalityType || 'this personality type'}: "${originalMessage}". Goal: ${goal || 'maximum impact'}. Provide 3 improved versions.`;
    
    let aiResponse;
    
    if (process.env.OPENAI_API_KEY && process.env.OPENAI_API_KEY !== 'your_api_key_here') {
      const response = await axios.post(
        'https://api.openai.com/v1/chat/completions',
        {
          model: 'gpt-3.5-turbo',
          messages: [
            { role: 'system', content: 'You are a messaging expert. Optimize texts to be more engaging and effective.' },
            { role: 'user', content: prompt }
          ],
          max_tokens: 250,
          temperature: 0.7
        },
        {
          headers: {
            'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
            'Content-Type': 'application/json'
          }
        }
      );
      aiResponse = response.data.choices[0].message.content;
    } else {
      aiResponse = `Here are 3 optimized versions:\n\n1. "Hey! Just saw something that reminded me of you 😊"\n2. "Random question but I need your take on something..."\n3. "You won't believe what just happened..."`;
    }
    
    res.json({
      success: true,
      optimized: aiResponse,
      options: parseOptions(aiResponse)
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// GET /videos - Get all videos
app.get('/videos', (req, res) => {
  res.json({
    success: true,
    videos: data.videos
  });
});

// GET /personality/:key - Get specific personality
app.get('/personality/:key', (req, res) => {
  const personality = data.personalities[req.params.key];
  if (!personality) {
    return res.status(404).json({ error: 'Personality not found' });
  }
  res.json({ success: true, personality });
});

// Helper: Generate mock AI response
function generateMockResponse(message, personalityType) {
  const responses = {
    default: [
      '"Hey! Been thinking about you 😊"',
      '"Random thought: you\'d love this place I found..."',
      '"Quick question for you..."'
    ],
    first: [
      `"Hey! I noticed you're into interesting things. Tell me more?"`,
      `"Your vibe caught my attention. What's your story?"`,
      `"I have a feeling we'd get along. Prove me right? 😉"`
    ],
    distant: [
      `Give them space - ${personalityType || 'this type'} needs room to miss you`,
      `Send something light and fun, no pressure`,
      `Focus on yourself - post something that shows you're thriving`
    ]
  };
  
  if (message.includes('first')) return responses.first.join('\n\n');
  if (message.includes('distant')) return responses.distant.join('\n\n');
  return responses.default.join('\n\n');
}

// Helper: Parse AI response into options
function parseOptions(text) {
  const lines = text.split('\n').filter(line => line.trim());
  return lines.map(line => line.replace(/^\d+\.?\s*"?|"?$/g, '').trim()).filter(l => l.length > 0);
}

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'Personality App API running' });
});

app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`📱 API: http://localhost:${PORT}`);
});
