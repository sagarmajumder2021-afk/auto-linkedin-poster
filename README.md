# 🤖 Auto LinkedIn Poster

**Automated LinkedIn posting bot that finds trending topics from Reddit and posts them with smart timing and natural writing.**

## 🚀 Features

- **Multi-Source Content**: Fetches trending posts from 7 different subreddits
- **Smart Scheduling**: Posts 3 times daily at optimal IST times
- **Natural Writing**: Creates engaging LinkedIn posts with emojis and hashtags
- **Error Handling**: Robust error handling for API failures
- **Rate Limiting**: 30-minute delays between posts to avoid spam

## 📋 Subreddits Monitored

- 🔒 **Hacking** (`r/hacking`)
- 🛡️ **Cybersecurity** (`r/cybersecurity`) 
- 💼 **Business** (`r/business`)
- 💰 **Finance** (`r/finance`)
- 🔧 **Technology** (`r/technology`)
- 🤖 **AI** (`r/artificial`)
- 🕵️ **Conspiracy** (`r/conspiracy`)

## ⏰ Posting Schedule

- **10:00 AM IST** (4:30 UTC)
- **11:00 AM IST** (5:30 UTC)  
- **10:00 PM IST** (16:30 UTC)

## 🛠️ Setup Instructions

### 1. LinkedIn API Setup

1. Go to [LinkedIn Developer Portal](https://developer.linkedin.com/)
2. Create a new app for your LinkedIn profile
3. Request access to **Marketing Developer Platform**
4. Generate an access token with `w_member_social` scope
5. Note your LinkedIn Person URN (format: `urn:li:person:your-id`)

### 2. Repository Setup

1. Fork this repository
2. Go to **Settings** → **Secrets and variables** → **Actions**
3. Add repository secret:
   - `LINKEDIN_ACCESS_TOKEN`: Your LinkedIn API access token

### 3. Customize Settings

Edit `.github/workflows/daily-linkedin-poster.yml`:

```yaml
# Update your LinkedIn Person URN
"author": "urn:li:person:your-linkedin-id-here"

# Modify posting schedule (optional)
schedule:
  - cron: '30 4 * * *'   # Change times as needed
```

### 4. Test the Workflow

1. Go to **Actions** tab in your repository
2. Select **Daily LinkedIn AI Poster**
3. Click **Run workflow** to test manually

## 📊 Post Format

Each LinkedIn post includes:

```
🚀 [Trending Topic Title]

💡 Summary: [First 180 characters]...
🔗 Source: [Reddit permalink]
#Trending #AI #CyberSecurity #Business #Finance #Tech #Innovation #2025 #Future
```

## 🔧 Customization Options

### Change Subreddits

Edit the `subreddits` dictionary in the workflow:

```python
subreddits = {
    "your_topic": "https://www.reddit.com/r/yourtopic/top.json?t=day",
    # Add more subreddits
}
```

### Modify Post Template

Update the `post_text` format:

```python
post_text = f"""
Your custom format here
Title: {title}
Link: {link}
Your hashtags: #YourTags
"""
```

### Adjust Posting Frequency

Change the cron schedule or posts per run:

```python
for i, post in enumerate(posts[:5]):  # Change from 3 to 5 posts
```

## 🚨 Important Notes

- **Rate Limits**: LinkedIn has strict rate limits - don't exceed 3 posts per run
- **Content Policy**: Ensure posts comply with LinkedIn's content guidelines
- **API Costs**: LinkedIn API may have usage costs for high-volume posting
- **Token Expiry**: LinkedIn tokens expire - monitor and refresh as needed

## 🐛 Troubleshooting

### Common Issues

1. **401 Unauthorized**: Check your LinkedIn access token
2. **403 Forbidden**: Verify API permissions and app approval
3. **429 Rate Limited**: Reduce posting frequency
4. **Reddit API Errors**: Check Reddit's API status

### Debug Mode

Add debug logging to the workflow:

```python
print(f"Fetched {len(posts)} posts")
print(f"Response: {response.status_code} - {response.text}")
```

## 📈 Analytics

Monitor your workflow performance:

1. Check **Actions** tab for run history
2. Review logs for success/failure rates
3. Track LinkedIn engagement on posted content

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is open source. Use responsibly and comply with LinkedIn's Terms of Service.

## ⚠️ Disclaimer

- Use at your own risk
- Ensure compliance with LinkedIn's API terms
- Monitor for policy changes
- Respect rate limits and content guidelines

---

**Created by Sagar Majumder** 🚀