<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
    }
    
    .content-title {
        font-size: 24px;
        font-weight: bold;
        color: #333;
    }
    
    .tabs {
        display: flex;
        border-bottom: 1px solid #eee;
        margin-bottom: 20px;
        overflow-x: auto;
    }
    
    .tab-item {
        padding: 15px 20px;
        cursor: pointer;
        transition: all 0.2s;
        white-space: nowrap;
    }
    
    .tab-item:hover {
        color: var(--bs-blind-dark);
    }
    
    .tab-item.active {
        font-weight: bold;
        color: var(--bs-blind-dark);
        border-bottom: 2px solid var(--bs-blind-dark);
    }
    
    .activity-section {
        display: none;
    }
    
    .activity-section.active {
        display: block;
    }
    
    .activity-list {
        width: 100%;
    }
    
    .activity-item {
        padding: 15px;
        border-bottom: 1px solid #eee;
        display: flex;
        align-items: center;
        justify-content: space-between;
        transition: background-color 0.2s;
    }
    
    .activity-item:hover {
        background-color: #f9f9f9;
    }
    
    .activity-info {
        flex: 1;
    }
    
    .activity-title {
        font-weight: bold;
        margin-bottom: 5px;
        color: #333;
    }
    
    .activity-meta {
        font-size: 14px;
        color: #888;
    }
    
    .activity-date {
        font-size: 14px;
        color: #888;
        min-width: 120px;
        text-align: right;
    }
    
    .activity-comment {
        margin-top: 8px;
        font-size: 14px;
        color: #444;
        background-color: #f9f9f9;
        padding: 8px 12px;
        border-radius: 6px;
        border-left: 3px solid var(--bs-primary-light);
    }
    
    .activity-description {
        margin-top: 8px;
        font-size: 14px;
        color: #444;
        line-height: 1.5;
    }
    
    .activity-result {
        margin-top: 8px;
        font-size: 14px;
        color: var(--bs-blind-dark);
        font-weight: bold;
    }
    
    .activity-summary {
        margin-top: 8px;
        font-size: 14px;
        color: #444;
        line-height: 1.5;
    }
    
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    
    .page-item {
        margin: 0 5px;
    }
    
    .page-link {
        display: block;
        padding: 8px 12px;
        border-radius: 6px;
        transition: all 0.2s;
        text-decoration: none;
        color: #333;
    }
    
    .page-link:hover {
        background-color: #f5f6f7;
    }
    
    .page-item.active .page-link {
        background-color: var(--bs-blind-dark);
        color: white;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background-color: var(--bs-primary-light);
        border-radius: 10px;
        padding: 20px;
        text-align: center;
    }
    
    .stat-card.accent {
        background-color: rgba(255, 125, 77, 0.1);
    }
    
    .stat-title {
        font-size: 14px;
        color: #666;
        margin-bottom: 5px;
    }
    
    .stat-value {
        font-size: 24px;
        font-weight: bold;
        color: #333;
    }
    
    .stat-card.primary .stat-value {
        color: var(--bs-blind-dark);
    }
    
    .stat-card.accent .stat-value {
        color: var(--bs-blind-accent);
    }
    
    .timer-table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 0 1px #eee;
    }
    
    .timer-table th,
    .timer-table td {
        padding: 15px;
        text-align: center;
        border-bottom: 1px solid #eee;
    }
    
    .timer-table th {
        background-color: var(--bs-primary-light);
        font-weight: bold;
        color: #444;
    }
    
    .progress-bar {
        width: 100%;
        height: 8px;
        background-color: #eee;
        border-radius: 4px;
        margin-top: 10px;
    }
    
    .progress-fill {
        height: 100%;
        border-radius: 4px;
        transition: width 0.3s ease;
    }
</style>

<div class="content-header">
    <h2 class="content-title">활동 내역 조회</h2>
</div>

<div class="tabs">
    <div class="tab-item active" data-tab="posts">작성한 게시글</div>
    <div class="tab-item" data-tab="comments">작성한 댓글</div>
    <div class="tab-item" data-tab="current-studies">참여중인 스터디</div>
    <div class="tab-item" data-tab="past-studies">참여했던 스터디</div>
    <div class="tab-item" data-tab="favorites">찜한 글</div>
    <div class="tab-item" data-tab="timer">타이머 기록</div>
</div>

<!-- 작성한 게시글 -->
<div class="activity-section active" id="posts-section">
    <div class="activity-list" id="posts-list">
        <div style="text-align: center; padding: 50px; color: #888;">
            게시글 목록을 불러오는 중...
        </div>
    </div>
    <div class="pagination" id="posts-pagination"></div>
</div>

<!-- 작성한 댓글 -->
<div class="activity-section" id="comments-section">
    <div class="activity-list" id="comments-list">
        <div style="text-align: center; padding: 50px; color: #888;">
            댓글 목록을 불러오는 중...
        </div>
    </div>
    <div class="pagination" id="comments-pagination"></div>
</div>

<!-- 참여중인 스터디 -->
<div class="activity-section" id="current-studies-section">
    <div class="activity-list" id="current-studies-list">
        <div style="text-align: center; padding: 50px; color: #888;">
            참여중인 스터디를 불러오는 중...
        </div>
    </div>
    <div class="pagination" id="current-studies-pagination"></div>
</div>

<!-- 참여했던 스터디 -->
<div class="activity-section" id="past-studies-section">
    <div class="activity-list" id="past-studies-list">
        <div style="text-align: center; padding: 50px; color: #888;">
            과거 스터디 목록을 불러오는 중...
        </div>
    </div>
    <div class="pagination" id="past-studies-pagination"></div>
</div>

<!-- 찜한 글 -->
<div class="activity-section" id="favorites-section">
    <div class="activity-list" id="favorites-list">
        <div style="text-align: center; padding: 50px; color: #888;">
            찜한 글 목록을 불러오는 중...
        </div>
    </div>
    <div class="pagination" id="favorites-pagination"></div>
</div>

<!-- 타이머 기록 -->
<div class="activity-section" id="timer-section">
    <!-- 학습 통계 -->
    <h3 style="font-size: 18px; font-weight: bold; margin-bottom: 15px; color: #444;">학습 통계</h3>
    <div class="stats-grid" id="timer-stats">
        <div class="stat-card primary">
            <div class="stat-title">금주 총 학습시간</div>
            <div class="stat-value">--시간 --분</div>
        </div>
        <div class="stat-card primary">
            <div class="stat-title">이번 달 총 학습시간</div>
            <div class="stat-value">--시간 --분</div>
        </div>
        <div class="stat-card accent">
            <div class="stat-title">가장 많이 학습한 과목</div>
            <div class="stat-value">--</div>
        </div>
        <div class="stat-card accent">
            <div class="stat-title">평균 목표 달성률</div>
            <div class="stat-value">--%</div>
        </div>
    </div>
    
    <h3 style="font-size: 18px; font-weight: bold; margin-bottom: 15px; color: #444;">타이머 기록</h3>
    <table class="timer-table">
        <thead>
            <tr>
                <th>날짜</th>
                <th>과목</th>
                <th>학습 시간</th>
                <th>달성률</th>
                <th>메모</th>
            </tr>
        </thead>
        <tbody id="timer-records">
            <tr>
                <td colspan="5" style="text-align: center; padding: 50px;">
                    타이머 기록을 불러오는 중...
                </td>
            </tr>
        </tbody>
    </table>
    <div class="pagination" id="timer-pagination"></div>
</div>

<script>
$(document).ready(function() {
    var currentTab = 'posts';
    var currentPages = {
        posts: 1,
        comments: 1,
        'current-studies': 1,
        'past-studies': 1,
        favorites: 1,
        timer: 1
    };
    
    // 첫 번째 탭 로드
    loadActivityData(currentTab);
    
    // 탭 전환 이벤트
    $('.tab-item').on('click', function() {
        var $this = $(this);
        var tabId = $this.data('tab');
        
        // 탭 활성화
        $('.tab-item').removeClass('active');
        $this.addClass('active');
        
        // 섹션 표시/숨김
        $('.activity-section').removeClass('active');
        $('#' + tabId + '-section').addClass('active');
        
        currentTab = tabId;
        
        // 해당 탭의 데이터가 아직 로드되지 않았으면 로드
        if (!$('#' + tabId + '-list').data('loaded')) {
            loadActivityData(tabId);
        }
    });
    
    // 페이지네이션 클릭 이벤트 (동적 요소)
    $(document).on('click', '.page-link', function(e) {
        e.preventDefault();
        var page = parseInt($(this).data('page'));
        var tab = $(this).closest('.activity-section').attr('id').replace('-section', '');
        
        currentPages[tab] = page;
        loadActivityData(tab);
    });
});

// 활동 데이터 로드 함수
function loadActivityData(tabId) {
    var endpoints = {
        'posts': '<%=request.getContextPath()%>/user/myPosts.do',
        'comments': '<%=request.getContextPath()%>/user/myComments.do',
        'current-studies': '<%=request.getContextPath()%>/user/currentStudies.do',
        'past-studies': '<%=request.getContextPath()%>/user/pastStudies.do',
        'favorites': '<%=request.getContextPath()%>/user/favorites.do',
        'timer': '<%=request.getContextPath()%>/user/timerRecords.do'
    };
    
    if (!endpoints[tabId]) return;
    
    var listSelector = '#' + tabId + '-list';
    var paginationSelector = '#' + tabId + '-pagination';
    
    $.ajax({
        url: endpoints[tabId],
        type: 'GET',
        data: { page: currentPages[tabId] || 1 },
        success: function(response) {
            if (tabId === 'timer') {
                loadTimerData(response);
            } else {
                loadGeneralActivityData(response, listSelector, paginationSelector, tabId);
            }
            
            // 로드 완료 표시
            $(listSelector).data('loaded', true);
        },
        error: function() {
            $(listSelector).html(`
                <div style="text-align: center; padding: 50px; color: #dc3545;">
                    데이터를 불러오는데 실패했습니다.
                    <br><button class="btn btn-sm btn-primary mt-2" onclick="loadActivityData('\${tabId}')">다시 시도</button>
                </div>
            `);
        }
    });
}

// 일반 활동 데이터 로드
function loadGeneralActivityData(response, listSelector, paginationSelector, tabId) {
    if (response.success && response.data.length > 0) {
        var content = '';
        
        $.each(response.data, function(index, item) {
            content += createActivityItem(item, tabId);
        });
        
        $(listSelector).html(content);
        createActivityPagination(response.totalPages, currentPages[tabId] || 1, paginationSelector);
    } else {
        $(listSelector).html(`
            <div style="text-align: center; padding: 50px; color: #888;">
                \${getEmptyMessage(tabId)}
            </div>
        `);
        $(paginationSelector).html('');
    }
}

// 타이머 데이터 로드
function loadTimerData(response) {
    if (response.success) {
        // 통계 업데이트
        if (response.stats) {
            $('#timer-stats .stat-card').eq(0).find('.stat-value').text(response.stats.weeklyTime || '--시간 --분');
            $('#timer-stats .stat-card').eq(1).find('.stat-value').text(response.stats.monthlyTime || '--시간 --분');
            $('#timer-stats .stat-card').eq(2).find('.stat-value').text(response.stats.topSubject || '--');
            $('#timer-stats .stat-card').eq(3).find('.stat-value').text(response.stats.avgAchievement || '--%');
        }
        
        // 타이머 기록 테이블 업데이트
        if (response.records && response.records.length > 0) {
            var tbody = '';
            $.each(response.records, function(index, record) {
                var achievementClass = record.achievement >= 100 ? 'success' : (record.achievement >= 80 ? 'warning' : 'danger');
                tbody += `
                    <tr>
                        <td>${record.studyDate}</td>
                        <td>${record.subject}</td>
                        <td>${record.studyTime}</td>
                        <td>
                            <span class="text-\${achievementClass}">\${record.achievement}%</span>
                            <div class="progress-bar">
                                <div class="progress-fill bg-\${achievementClass}" style="width: \${record.achievement}%"></div>
                            </div>
                        </td>
                        <td style="text-align: left; max-width: 200px;">${record.memo || '-'}</td>
                    </tr>
                `;
            });
            $('#timer-records').html(tbody);
            createActivityPagination(response.totalPages, currentPages.timer, '#timer-pagination');
        } else {
            $('#timer-records').html(`
                <tr>
                    <td colspan="5" style="text-align: center; padding: 50px; color: #888;">
                        타이머 기록이 없습니다.
                    </td>
                </tr>
            `);
            $('#timer-pagination').html('');
        }
    }
}

// 활동 아이템 생성
function createActivityItem(item, tabId) {
    var extraContent = '';
    
    switch(tabId) {
        case 'comments':
            if (item.comment) {
                extraContent = `<div class="activity-comment">"\${item.comment}"</div>`;
            }
            break;
        case 'current-studies':
        case 'past-studies':
            if (item.description) {
                extraContent = `<div class="activity-description">\${item.description}</div>`;
            }
            if (item.result && tabId === 'past-studies') {
                extraContent += `<div class="activity-result">활동 성과: \${item.result}</div>`;
            }
            break;
        case 'favorites':
            if (item.summary) {
                extraContent = `<div class="activity-summary">\${item.summary}</div>`;
            }
            break;
    }
    
    return `
        <div class="activity-item">
            <div class="activity-info">
                <div class="activity-title">\${item.title}</div>
                <div class="activity-meta">\${item.meta}</div>
                \${extraContent}
            </div>
            <div class="activity-date">\${item.date}</div>
        </div>
    `;
}

// 빈 데이터 메시지
function getEmptyMessage(tabId) {
    var messages = {
        'posts': '작성한 게시글이 없습니다.',
        'comments': '작성한 댓글이 없습니다.',
        'current-studies': '참여중인 스터디가 없습니다.',
        'past-studies': '참여했던 스터디가 없습니다.',
        'favorites': '찜한 글이 없습니다.'
    };
    return messages[tabId] || '데이터가 없습니다.';
}

// 페이지네이션 생성
function createActivityPagination(totalPages, currentPage, selector) {
    if (totalPages <= 1) {
        $(selector).html('');
        return;
    }
    
    var pagination = '';
    var startPage = Math.max(1, currentPage - 2);
    var endPage = Math.min(totalPages, currentPage + 2);
    
    if (currentPage > 1) {
        pagination += `<div class="page-item"><a href="#" class="page-link" data-page="\${currentPage - 1}">‹</a></div>`;
    }
    
    for (var i = startPage; i <= endPage; i++) {
        var activeClass = i === currentPage ? 'active' : '';
        pagination += `<div class="page-item \${activeClass}"><a href="#" class="page-link" data-page="\${i}">\${i}</a></div>`;
    }
    
    if (currentPage < totalPages) {
        pagination += `<div class="page-item"><a href="#" class="page-link" data-page="\${currentPage + 1}">›</a></div>`;
    }
    
    $(selector).html(pagination);
}
</script>