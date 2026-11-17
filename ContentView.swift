import SwiftUI

struct Skin: Identifiable {
    let id = UUID()
    let name: String
    let hero: String
    let rarity: String
    let symbol: String
}

struct ContentView: View {
    @AppStorage("killNoticeEnabled") private var killNoticeEnabled = true
    @AppStorage("soundEnabled") private var soundEnabled = true
    @State private var selectedTab = 0
    @State private var showCleanAlert = false
    @State private var previewCount = 0
    @State private var showFloatingMenu = false
    @State private var floatingOffset = CGSize.zero

    private let skins = [
        Skin(name: "Tinh Vân Kiếm", hero: "Nakroth", rarity: "Sử thi", symbol: "sparkles"),
        Skin(name: "Thủy Thần", hero: "Krixi", rarity: "Hữu hạn", symbol: "drop.fill"),
        Skin(name: "Dạ Hội", hero: "Tel'Annas", rarity: "Cao cấp", symbol: "moon.stars.fill"),
        Skin(name: "Hỏa Long", hero: "Yena", rarity: "Sử thi", symbol: "flame.fill")
    ]

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.035, green: 0.055, blue: 0.13), Color(red: 0.12, green: 0.08, blue: 0.25)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                header
                if selectedTab == 0 { homeView } else if selectedTab == 1 { skinView } else { settingsView }
                tabBar
            }
            .overlay(alignment: .bottomTrailing) {
                VStack(alignment: .trailing, spacing: 12) {
                    if showFloatingMenu {
                        floatingMenu
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    Button {
                        withAnimation(.spring(response: 0.32, dampingFraction: 0.78)) {
                            showFloatingMenu.toggle()
                        }
                    } label: {
                        Image(systemName: showFloatingMenu ? "xmark" : "gamecontroller.fill")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 58, height: 58)
                            .background(LinearGradient(colors: [.purple, .blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white.opacity(0.35), lineWidth: 1.5))
                            .shadow(color: .cyan.opacity(0.35), radius: 12, y: 5)
                    }
                    .offset(floatingOffset)
                    .gesture(DragGesture().onChanged { value in
                        floatingOffset = value.translation
                    })
                }
                .padding(.trailing, 18)
                .padding(.bottom, 88)
            }
        }
        .preferredColorScheme(.dark)
        .alert("Đã làm mới dữ liệu xem trước", isPresented: $showCleanAlert) {
            Button("Đóng", role: .cancel) { }
        } message: {
            Text("Chỉ dữ liệu tạm của ứng dụng mẫu được đặt lại. Không tác động đến Liên Quân Mobile.")
        }
    }


    private var floatingMenu: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("LQ MENU").font(.system(size: 14, weight: .black, design: .rounded)).tracking(1)
                    Text("Bảng điều khiển Skin Studio").font(.system(size: 10)).foregroundStyle(.white.opacity(0.6))
                }
                Spacer()
                Text("DEMO").font(.system(size: 9, weight: .heavy)).padding(.horizontal, 8).padding(.vertical, 5).background(Color.cyan.opacity(0.18)).foregroundStyle(.cyan).clipShape(Capsule())
            }
            Divider().overlay(Color.white.opacity(0.15))
            menuAction("Trang chủ", icon: "house.fill", tab: 0)
            menuAction("Thư viện skin", icon: "sparkles", tab: 1)
            menuAction("Cài đặt", icon: "slider.horizontal.3", tab: 2)
            Text("Menu chỉ hoạt động bên trong LQ Skin Studio; không phủ lên hoặc điều khiển Liên Quân Mobile.")
                .font(.system(size: 9)).foregroundStyle(.white.opacity(0.48)).fixedSize(horizontal: false, vertical: true)
        }
        .padding(15)
        .frame(width: 245)
        .background(.ultraThinMaterial)
        .background(Color(red: 0.08, green: 0.10, blue: 0.20).opacity(0.94))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white.opacity(0.15), lineWidth: 1))
        .shadow(color: .black.opacity(0.35), radius: 18, y: 8)
    }

    private func menuAction(_ title: String, icon: String, tab: Int) -> some View {
        Button {
            selectedTab = tab
            withAnimation(.spring(response: 0.32, dampingFraction: 0.78)) { showFloatingMenu = false }
        } label: {
            HStack(spacing: 10) {
                Image(systemName: icon).foregroundStyle(.cyan).frame(width: 22)
                Text(title).font(.system(size: 12, weight: .semibold)).foregroundStyle(.white)
                Spacer()
                Image(systemName: "chevron.right").font(.system(size: 10, weight: .bold)).foregroundStyle(.white.opacity(0.35))
            }
            .padding(.vertical, 5)
            .contentShape(Rectangle())
        }
    }

    private var header: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 14).fill(Color.cyan.opacity(0.18)).frame(width: 46, height: 46)
                Image(systemName: "shield.lefthalf.filled").font(.system(size: 22, weight: .bold)).foregroundStyle(.cyan)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("LIÊN QUÂN").font(.system(size: 11, weight: .heavy, design: .rounded)).tracking(2).foregroundStyle(.cyan)
                Text("SKIN STUDIO").font(.system(size: 20, weight: .black, design: .rounded)).foregroundStyle(.white)
            }
            Spacer()
            Text("DEMO").font(.system(size: 10, weight: .heavy)).tracking(1).padding(.horizontal, 10).padding(.vertical, 6).background(Color.orange.opacity(0.18)).foregroundStyle(.orange).clipShape(Capsule())
        }.padding(.horizontal, 20).padding(.top, 14).padding(.bottom, 18)
    }

    private var homeView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 18) {
                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 24).fill(LinearGradient(colors: [Color.indigo, Color.purple.opacity(0.75), Color.cyan.opacity(0.45)], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(height: 168)
                    Circle().fill(Color.white.opacity(0.08)).frame(width: 170).offset(x: 205, y: -38)
                    Image(systemName: "crown.fill").font(.system(size: 68)).foregroundStyle(.white.opacity(0.20)).offset(x: 245, y: -38)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("BỘ SƯU TẬP SKIN").font(.system(size: 11, weight: .bold)).tracking(1.8).foregroundStyle(.cyan.opacity(0.95))
                        Text("Khám phá phong cách\nanh hùng của bạn").font(.system(size: 23, weight: .black, design: .rounded)).foregroundStyle(.white)
                        Text("Thư viện xem trước giao diện").font(.system(size: 12)).foregroundStyle(.white.opacity(0.72))
                    }.padding(20)
                }
                HStack(spacing: 12) {
                    metric("20", label: "Phiếu demo", icon: "doc.text.fill", tint: .orange)
                    metric(previewCount.description, label: "Lượt xem", icon: "eye.fill", tint: .cyan)
                }
                sectionTitle("TÍNH NĂNG NHANH", subtitle: "Điều khiển giao diện ứng dụng mẫu")
                featureRow(title: "Thông báo hạ gục", detail: "Bật/tắt mô phỏng thông báo", icon: "bolt.fill", tint: .orange, isOn: $killNoticeEnabled)
                featureRow(title: "Âm thanh giao diện", detail: "Âm thanh trong ứng dụng mẫu", icon: "speaker.wave.2.fill", tint: .cyan, isOn: $soundEnabled)
                Button { showCleanAlert = true } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "arrow.clockwise.circle.fill").font(.system(size: 20)).foregroundStyle(.mint)
                        VStack(alignment: .leading, spacing: 3) { Text("Làm mới dữ liệu xem trước").font(.system(size: 14, weight: .semibold)).foregroundStyle(.white); Text("Chỉ xóa trạng thái demo trong app này").font(.system(size: 11)).foregroundStyle(.white.opacity(0.55)) }
                        Spacer(); Image(systemName: "chevron.right").foregroundStyle(.white.opacity(0.35))
                    }.padding(15).background(Color.white.opacity(0.07)).clipShape(RoundedRectangle(cornerRadius: 16))
                }
                Text("Ứng dụng độc lập để xem trước giao diện; không sửa dữ liệu game, mở khóa skin máy chủ hoặc gửi/xóa tố cáo.").font(.system(size: 11)).foregroundStyle(.white.opacity(0.45)).padding(.top, 2)
            }.padding(.horizontal, 18).padding(.bottom, 20)
        }
    }

    private var skinView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                sectionTitle("THƯ VIỆN SKIN", subtitle: "Các mục minh họa — không phải skin đã mở khóa")
                ForEach(skins) { skin in
                    Button { previewCount += 1 } label: {
                        HStack(spacing: 14) {
                            RoundedRectangle(cornerRadius: 15).fill(LinearGradient(colors: [.cyan.opacity(0.25), .purple.opacity(0.35)], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 64, height: 64)
                                .overlay(Image(systemName: skin.symbol).font(.system(size: 25, weight: .semibold)).foregroundStyle(.white))
                            VStack(alignment: .leading, spacing: 5) {
                                Text(skin.name).font(.system(size: 15, weight: .bold)).foregroundStyle(.white)
                                Text(skin.hero).font(.system(size: 12)).foregroundStyle(.white.opacity(0.65))
                                Text(skin.rarity.uppercased()).font(.system(size: 9, weight: .heavy)).tracking(1).foregroundStyle(.cyan)
                            }
                            Spacer()
                            Image(systemName: "eye").foregroundStyle(.cyan)
                        }.padding(13).background(Color.white.opacity(0.07)).clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                }
            }.padding(.horizontal, 18).padding(.bottom, 20)
        }
    }

    private var settingsView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                sectionTitle("CÀI ĐẶT", subtitle: "Tùy chỉnh ứng dụng Skin Studio")
                featureRow(title: "Thông báo hạ gục", detail: "Trạng thái được lưu trên thiết bị", icon: "bolt.fill", tint: .orange, isOn: $killNoticeEnabled)
                featureRow(title: "Âm thanh giao diện", detail: "Âm thanh trong ứng dụng mẫu", icon: "speaker.wave.2.fill", tint: .cyan, isOn: $soundEnabled)
                HStack { Label("Phiên bản", systemImage: "info.circle"); Spacer(); Text("1.0.0 · iOS 16+").foregroundStyle(.white.opacity(0.55)) }.font(.system(size: 13)).padding(15).background(Color.white.opacity(0.07)).clipShape(RoundedRectangle(cornerRadius: 15))
                Text("Không có key. Không kết nối máy chủ Liên Quân. Không can thiệp ứng dụng game.").font(.system(size: 11)).foregroundStyle(.white.opacity(0.5))
            }.padding(18)
        }
    }

    private var tabBar: some View {
        HStack {
            tabButton("house.fill", title: "Trang chủ", index: 0)
            tabButton("sparkles", title: "Skin", index: 1)
            tabButton("slider.horizontal.3", title: "Cài đặt", index: 2)
        }.padding(.top, 11).padding(.bottom, 8).background(Color.black.opacity(0.28))
    }

    private func tabButton(_ icon: String, title: String, index: Int) -> some View {
        Button { selectedTab = index } label: {
            VStack(spacing: 5) { Image(systemName: icon).font(.system(size: 17, weight: .semibold)); Text(title).font(.system(size: 10, weight: .semibold)) }
                .foregroundStyle(selectedTab == index ? Color.cyan : Color.white.opacity(0.45)).frame(maxWidth: .infinity)
        }
    }

    private func metric(_ value: String, label: String, icon: String, tint: Color) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon).font(.system(size: 17)).foregroundStyle(tint).frame(width: 36, height: 36).background(tint.opacity(0.13)).clipShape(RoundedRectangle(cornerRadius: 11))
            VStack(alignment: .leading, spacing: 2) { Text(value).font(.system(size: 19, weight: .black, design: .rounded)).foregroundStyle(.white); Text(label).font(.system(size: 10)).foregroundStyle(.white.opacity(0.55)) }
            Spacer(minLength: 0)
        }.padding(12).frame(maxWidth: .infinity, alignment: .leading).background(Color.white.opacity(0.07)).clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func sectionTitle(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) { Text(title).font(.system(size: 12, weight: .heavy)).tracking(1.4).foregroundStyle(.white); Text(subtitle).font(.system(size: 11)).foregroundStyle(.white.opacity(0.5)) }.padding(.top, 2)
    }

    private func featureRow(title: String, detail: String, icon: String, tint: Color, isOn: Binding<Bool>) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon).font(.system(size: 17)).foregroundStyle(tint).frame(width: 38, height: 38).background(tint.opacity(0.13)).clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 3) { Text(title).font(.system(size: 13, weight: .semibold)).foregroundStyle(.white); Text(detail).font(.system(size: 10)).foregroundStyle(.white.opacity(0.5)) }
            Spacer(); Toggle(title, isOn: isOn).labelsHidden().tint(.cyan)
        }.padding(13).background(Color.white.opacity(0.07)).clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
